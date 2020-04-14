Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A66CC352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1390A2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391445AbgDNQZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391500AbgDNQZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:25:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9B4C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:25:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A32982A0ECD
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_ishtp: free ishtp buffer
 before sending event
To:     Mathew King <mathewk@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Jett Rink <jettrink@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
References: <20200410162305.76638-1-mathewk@chromium.org>
 <20200410162305.76638-2-mathewk@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <6690592e-5423-2f9c-4f59-29d5149c488a@collabora.com>
Date:   Tue, 14 Apr 2020 18:25:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200410162305.76638-2-mathewk@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jett and Mathew,

Thank you for the patch.

On 10/4/20 18:23, Mathew King wrote:
> From: Jett Rink <jettrink@chromium.org>
> 
> Recycle the ISH buffer before notifying of a response or an event. Often
> a new message is sent in response to an event and in high traffic
> scenarios this can lead to exhausting all available buffers. We can
> ensure we are using the fewest buffers possible by freeing buffers as
> soon as they are used.
> 
> Signed-off-by: Jett Rink <jettrink@chromium.org>
> Signed-off-by: Mathew King <mathewk@chromium.org>

Queued for 5.8

> ---
> v2: Reword the commit message
> ---
>  drivers/platform/chrome/cros_ec_ishtp.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
> index e673a7f738fc..ed794a7ddba9 100644
> --- a/drivers/platform/chrome/cros_ec_ishtp.c
> +++ b/drivers/platform/chrome/cros_ec_ishtp.c
> @@ -303,6 +303,10 @@ static void process_recv(struct ishtp_cl *cros_ish_cl,
>  		       rb_in_proc->buffer.data, data_len);
>  
>  error_wake_up:
> +		/* Free the buffer since we copied data or didn't need it */
> +		ishtp_cl_io_rb_recycle(rb_in_proc);
> +		rb_in_proc = NULL;
> +
>  		/* Set flag before waking up the caller */
>  		client_data->response.received = true;
>  
> @@ -312,12 +316,14 @@ static void process_recv(struct ishtp_cl *cros_ish_cl,
>  		break;
>  
>  	case CROS_MKBP_EVENT:
> +		/* Free the buffer. This is just an event without data */
> +		ishtp_cl_io_rb_recycle(rb_in_proc);
> +		rb_in_proc = NULL;
>  		/*
>  		 * Set timestamp from beginning of function since we actually
>  		 * got an incoming MKBP event
>  		 */
>  		client_data->ec_dev->last_event_time = timestamp;
> -		/* The event system doesn't send any data in buffer */
>  		schedule_work(&client_data->work_ec_evt);
>  
>  		break;
> @@ -327,8 +333,9 @@ static void process_recv(struct ishtp_cl *cros_ish_cl,
>  	}
>  
>  end_error:
> -	/* Free the buffer */
> -	ishtp_cl_io_rb_recycle(rb_in_proc);
> +	/* Free the buffer if we already haven't */
> +	if (rb_in_proc)
> +		ishtp_cl_io_rb_recycle(rb_in_proc);
>  
>  	up_read(&init_lock);
>  }
> 
