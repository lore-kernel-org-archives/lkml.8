Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DFCC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 07:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0DD20757
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 07:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgDJHip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 03:38:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46672 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgDJHip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 03:38:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C1983298622
Subject: Re: [PATCH 1/2] platform/chrome: skip old cros_ec responses
To:     Mat King <mathewk@google.com>
Cc:     Mathew King <mathewk@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jett Rink <jettrink@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200408181638.184559-1-mathewk@chromium.org>
 <bb66112e-5830-878c-4ce7-ac462833d61b@collabora.com>
 <CAL_quvQH5GQ1KNSdhtMpvP71NrjbCev-W-4BdTMCiKYDFc000A@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <52a60dbb-5841-fe6d-b5c0-f953a3a0c5d8@collabora.com>
Date:   Fri, 10 Apr 2020 09:38:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAL_quvQH5GQ1KNSdhtMpvP71NrjbCev-W-4BdTMCiKYDFc000A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mat,

On 10/4/20 1:59, Mat King wrote:
> On Thu, Apr 9, 2020 at 4:42 PM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>>
>> Hi Mathew,
>>
>> Thanks for your patch.
>>
>> On 8/4/20 20:16, Mathew King wrote:
>>> From: Jett Rink <jettrink@chromium.org>
>>>
>>> The ISHTP layer can give us old responses that we already gave up on. We
>>> do not want to interpret these old responses as the current response we
>>> are waiting for.
>>>
>>
>> Looking at the code and with the above explanation I am not sure I get what is
>> doing this patch, could you explain a bit more, thanks.
> 
> The cros_ish should only have one request in flight at a time, we send
> the request and wait for the response from the ISH. If the ISH is too
> slow to respond we give up on that request and we can send a new
> request. The ISH may still send the response to the request that timed
> out and without this patch we would treat the old response as the
> response to the current command. This is a condition that should not
> normally happen but we have seen it with a bad ISH image. So we just
> add an Id to the request header which is copied into the response
> header when the ISH processes the message to ensure that response is
> for the current request.
> 

Could you include that in the commit message. Thanks.

>>
>>> Signed-off-by: Jett Rink <jettrink@chromium.org>
>>> Signed-off-by: Mathew King <mathewk@chromium.org>
>>> ---
>>>  drivers/platform/chrome/cros_ec_ishtp.c | 32 ++++++++++++++++++-------
>>>  1 file changed, 23 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
>>> index 93a71e93a2f1..6f90deb5cf55 100644
>>> --- a/drivers/platform/chrome/cros_ec_ishtp.c
>>> +++ b/drivers/platform/chrome/cros_ec_ishtp.c
>>> @@ -48,7 +48,8 @@ static const guid_t cros_ish_guid =
>>>  struct header {
>>>       u8 channel;
>>>       u8 status;
>>> -     u8 reserved[2];
>>> +     u8 id;
>>> +     u8 reserved;
>>>  } __packed;
>>>
>>>  struct cros_ish_out_msg {
>>> @@ -90,6 +91,7 @@ static DECLARE_RWSEM(init_lock);
>>>   * data exceeds this value, we log an error.
>>>   * @size: Actual size of data received from firmware.
>>>   * @error: 0 for success, negative error code for a failure in process_recv().
>>> + * @expected_id: Expected id for response that we are waiting on.
>>>   * @received: Set to true on receiving a valid firmware      response to host command
>>>   * @wait_queue: Wait queue for host to wait for firmware response.
>>>   */
>>> @@ -98,6 +100,7 @@ struct response_info {
>>>       size_t max_size;
>>>       size_t size;
>>>       int error;
>>> +     u8 expected_id;
>>>       bool received;
>>>       wait_queue_head_t wait_queue;
>>>  };
>>> @@ -162,6 +165,7 @@ static int ish_send(struct ishtp_cl_data *client_data,
>>>                   u8 *out_msg, size_t out_size,
>>>                   u8 *in_msg, size_t in_size)
>>>  {
>>> +     static u8 current_id;
>>>       int rv;
>>>       struct header *out_hdr = (struct header *)out_msg;
>>>       struct ishtp_cl *cros_ish_cl = client_data->cros_ish_cl;
>>> @@ -174,8 +178,11 @@ static int ish_send(struct ishtp_cl_data *client_data,
>>>       client_data->response.data = in_msg;
>>>       client_data->response.max_size = in_size;
>>>       client_data->response.error = 0;
>>> +     client_data->response.expected_id = ++current_id;
>>
>> So on every ish_send call this variable is increased in a range 1 to 255 first,
>> then overflows and goes from 0 to 255. Is this what you want to do?
> 
> On our internal code review this was switched from a post increment to
> a pre increment so that the variable name made sense. The id itself
> doesn't really matter as long as it is changed every response. We
> could also call it next_id and do a post increment and then we would
> start at 0. Do you have preference?
> 

So is like a token (actually a ring of tokens) to make sure the response matches
with the question.

if (response.token != in_msg->hdr.token)
    ignore the response

This id dancing (expected_id, current_id, id) confused me a bit. IMO the code
will be more readable simply with token or id for both, the response and the
question, and have a next_token/id. But I don't have a strong preference, so I
will let you the final decision.

>>
>>>       client_data->response.received = false;
>>>
>>> +     out_hdr->id = client_data->response.expected_id;
>>> +
>>>       rv = ishtp_cl_send(cros_ish_cl, out_msg, out_size);
>>>       if (rv) {
>>>               dev_err(cl_data_to_dev(client_data),
>>> @@ -249,17 +256,23 @@ static void process_recv(struct ishtp_cl *cros_ish_cl,
>>>
>>>       switch (in_msg->hdr.channel) {
>>>       case CROS_EC_COMMAND:
>>> -             /* Sanity check */
>>> -             if (!client_data->response.data) {
>>> +             if (client_data->response.received) {
>>>                       dev_err(dev,
>>> -                             "Receiving buffer is null. Should be allocated by calling function\n");
>>> -                     client_data->response.error = -EINVAL;
>>> -                     goto error_wake_up;
>>> +                             "Previous firmware message not yet processed\n");
>>> +                     goto end_error;
>>>               }
>>>
>>> -             if (client_data->response.received) {
>>> +             if (client_data->response.expected_id != in_msg->hdr.id) {
>>
>> And here you compare that the response received matches with the message id. I
>> assume the ISH is sending a sequential id on every message?
> 
> The ISH will copy the id from the request to the id of the response
> 

Ok.

>>
>>>                       dev_err(dev,
>>> -                             "Previous firmware message not yet processed\n");
>>> +                             "Dropping old response id %d\n",
>>> +                             in_msg->hdr.id);
>>
>>
>> How often this message appears?
> 
> Since we have stabilized our ISH code it rarely happens if ever. If it
> does happen it indicates an error in the ISH code or the driver code
> but we still want to attempt to recover gracefully if possible.
> 

Still, I am wondering if is a good idea to have this message rate limited
(dev_err_ratelimited) If for some reason the ISH code is bad or losts sync the
kernel can be flooded by this message and being annoying.

>>
>>> +                     goto end_error;
>>> +             }
>>> +
>>> +             /* Sanity check */
>>> +             if (!client_data->response.data) {
>>> +                     dev_err(dev,
>>> +                             "Receiving buffer is null. Should be allocated by calling function\n");
>>>                       client_data->response.error = -EINVAL;
>>>                       goto error_wake_up;
>>>               }
>>> @@ -289,9 +302,10 @@ static void process_recv(struct ishtp_cl *cros_ish_cl,
>>>               memcpy(client_data->response.data,
>>>                      rb_in_proc->buffer.data, data_len);
>>>
>>> +error_wake_up:
>>>               /* Set flag before waking up the caller */
>>>               client_data->response.received = true;
>>> -error_wake_up:
>>> +
>>>               /* Wake the calling thread */
>>>               wake_up_interruptible(&client_data->response.wait_queue);
>>>
>>>

Please resend the patch modifying the commit message and using

'platform/chrome: cros_ec_ishtp: ...'

as title prefix.

Thanks,
 Enric

