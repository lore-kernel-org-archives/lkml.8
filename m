Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46689C352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 291232076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391462AbgDNQYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391445AbgDNQYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:24:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DB4C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:24:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 99A302A1ADC
Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec_ishtp: skip old cros_ec
 responses
To:     Mathew King <mathewk@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Jett Rink <jettrink@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
References: <20200410162305.76638-1-mathewk@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <c0e0c052-17bd-fea7-a4a8-07b4afbe56bd@collabora.com>
Date:   Tue, 14 Apr 2020 18:24:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200410162305.76638-1-mathewk@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jett and Mathew,

Thank you for the patch

On 10/4/20 18:23, Mathew King wrote:
> From: Jett Rink <jettrink@chromium.org>
> 
> The ISHTP layer can give us old responses that we already gave up on. We
> do not want to interpret these old responses as the current response we
> are waiting for.
> 
> The cros_ish should only have one request in flight at a time. We send
> the request and wait for the response from the ISH. If the ISH is too
> slow to respond we give up on that request and we can send a new
> request. The ISH may still send the response to the request that timed
> out and without this we treat the old response as the response to the
> current command. This is a condition that should not normally happen but
> it has been observed with a bad ISH image. So add a token to the request
> header which is copied into the response header when the ISH processes
> the message to ensure that response is for the current request.
> 
> Signed-off-by: Jett Rink <jettrink@chromium.org>
> Signed-off-by: Mathew King <mathewk@chromium.org>

Queued for 5.8

> ---
> v2: - Change from using id to token
>     - Reword the commit message
> ---
>  drivers/platform/chrome/cros_ec_ishtp.c | 32 ++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
> index 93a71e93a2f1..e673a7f738fc 100644
> --- a/drivers/platform/chrome/cros_ec_ishtp.c
> +++ b/drivers/platform/chrome/cros_ec_ishtp.c
> @@ -48,7 +48,8 @@ static const guid_t cros_ish_guid =
>  struct header {
>  	u8 channel;
>  	u8 status;
> -	u8 reserved[2];
> +	u8 token;
> +	u8 reserved;
>  } __packed;
>  
>  struct cros_ish_out_msg {
> @@ -90,6 +91,7 @@ static DECLARE_RWSEM(init_lock);
>   * data exceeds this value, we log an error.
>   * @size: Actual size of data received from firmware.
>   * @error: 0 for success, negative error code for a failure in process_recv().
> + * @token: Expected token for response that we are waiting on.
>   * @received: Set to true on receiving a valid firmware	response to host command
>   * @wait_queue: Wait queue for host to wait for firmware response.
>   */
> @@ -98,6 +100,7 @@ struct response_info {
>  	size_t max_size;
>  	size_t size;
>  	int error;
> +	u8 token;
>  	bool received;
>  	wait_queue_head_t wait_queue;
>  };
> @@ -162,6 +165,7 @@ static int ish_send(struct ishtp_cl_data *client_data,
>  		    u8 *out_msg, size_t out_size,
>  		    u8 *in_msg, size_t in_size)
>  {
> +	static u8 next_token;
>  	int rv;
>  	struct header *out_hdr = (struct header *)out_msg;
>  	struct ishtp_cl *cros_ish_cl = client_data->cros_ish_cl;
> @@ -174,8 +178,11 @@ static int ish_send(struct ishtp_cl_data *client_data,
>  	client_data->response.data = in_msg;
>  	client_data->response.max_size = in_size;
>  	client_data->response.error = 0;
> +	client_data->response.token = next_token++;
>  	client_data->response.received = false;
>  
> +	out_hdr->token = client_data->response.token;
> +
>  	rv = ishtp_cl_send(cros_ish_cl, out_msg, out_size);
>  	if (rv) {
>  		dev_err(cl_data_to_dev(client_data),
> @@ -249,17 +256,23 @@ static void process_recv(struct ishtp_cl *cros_ish_cl,
>  
>  	switch (in_msg->hdr.channel) {
>  	case CROS_EC_COMMAND:
> -		/* Sanity check */
> -		if (!client_data->response.data) {
> +		if (client_data->response.received) {
>  			dev_err(dev,
> -				"Receiving buffer is null. Should be allocated by calling function\n");
> -			client_data->response.error = -EINVAL;
> -			goto error_wake_up;
> +				"Previous firmware message not yet processed\n");
> +			goto end_error;
>  		}
>  
> -		if (client_data->response.received) {
> +		if (client_data->response.token != in_msg->hdr.token) {
> +			dev_err_ratelimited(dev,
> +					    "Dropping old response token %d\n",
> +					    in_msg->hdr.token);
> +			goto end_error;
> +		}
> +
> +		/* Sanity check */
> +		if (!client_data->response.data) {
>  			dev_err(dev,
> -				"Previous firmware message not yet processed\n");
> +				"Receiving buffer is null. Should be allocated by calling function\n");
>  			client_data->response.error = -EINVAL;
>  			goto error_wake_up;
>  		}
> @@ -289,9 +302,10 @@ static void process_recv(struct ishtp_cl *cros_ish_cl,
>  		memcpy(client_data->response.data,
>  		       rb_in_proc->buffer.data, data_len);
>  
> +error_wake_up:
>  		/* Set flag before waking up the caller */
>  		client_data->response.received = true;
> -error_wake_up:
> +
>  		/* Wake the calling thread */
>  		wake_up_interruptible(&client_data->response.wait_queue);
>  
> 
