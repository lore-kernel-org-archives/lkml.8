Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264E5C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC98208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgCJVbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:31:13 -0400
Received: from ale.deltatee.com ([207.54.116.67]:42244 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgCJVbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:31:13 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jBmT1-0001Zy-DR; Tue, 10 Mar 2020 15:31:12 -0600
To:     Sanjay R Mehta <sanju.mehta@amd.com>, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com, arindam.nath@amd.com,
        Shyam-sundar.S-k@amd.com
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
References: <1583873694-19151-1-git-send-email-sanju.mehta@amd.com>
 <1583873694-19151-3-git-send-email-sanju.mehta@amd.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3c350277-8fe6-04b2-673e-7d4c8fb6ce24@deltatee.com>
Date:   Tue, 10 Mar 2020 15:31:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1583873694-19151-3-git-send-email-sanju.mehta@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Shyam-sundar.S-k@amd.com, arindam.nath@amd.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, sanju.mehta@amd.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 2/5] ntb_perf: send command in response to EAGAIN
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-03-10 2:54 p.m., Sanjay R Mehta wrote:
> From: Arindam Nath <arindam.nath@amd.com>
> 
> perf_spad_cmd_send() and perf_msg_cmd_send() return
> -EAGAIN after trying to send commands for a maximum
> of MSG_TRIES re-tries. But currently there is no
> handling for this error. These functions are invoked
> from perf_service_work() through function pointers,
> so rather than simply call these functions is not
> enough. We need to make sure to invoke them again in
> case of -EAGAIN. Since peer status bits were cleared
> before calling these functions, we set the same status
> bits before queueing the work again for later invocation.
> This way we simply won't go ahead and initialize the
> XLAT registers wrongfully in case sending the very first
> command itself fails.

So what happens if there's an actual non-recoverable error that causes
perf_msg_cmd_send() to fail? Are you proposing it just requeues high
priority work forever?

I never really reviewed this stuff properly but it looks like it has a
bunch of problems. Using the high priority work queue for some low
priority setup work seems wrong, at the very least. The spad and msg
send loops also look like they have a bunch of inter-host race condition
problems as well. Yikes.

Logan



> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---
>  drivers/ntb/test/ntb_perf.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 6d16628..9068e42 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -625,14 +625,24 @@ static void perf_service_work(struct work_struct *work)
>  {
>  	struct perf_peer *peer = to_peer_service(work);
>  
> -	if (test_and_clear_bit(PERF_CMD_SSIZE, &peer->sts))
> -		perf_cmd_send(peer, PERF_CMD_SSIZE, peer->outbuf_size);
> +	if (test_and_clear_bit(PERF_CMD_SSIZE, &peer->sts)) {
> +		if (perf_cmd_send(peer, PERF_CMD_SSIZE, peer->outbuf_size)
> +		    == -EAGAIN) {
> +			set_bit(PERF_CMD_SSIZE, &peer->sts);
> +			(void)queue_work(system_highpri_wq, &peer->service);
> +		}
> +	}
>  
>  	if (test_and_clear_bit(PERF_CMD_RSIZE, &peer->sts))
>  		perf_setup_inbuf(peer);
>  
> -	if (test_and_clear_bit(PERF_CMD_SXLAT, &peer->sts))
> -		perf_cmd_send(peer, PERF_CMD_SXLAT, peer->inbuf_xlat);
> +	if (test_and_clear_bit(PERF_CMD_SXLAT, &peer->sts)) {
> +		if (perf_cmd_send(peer, PERF_CMD_SXLAT, peer->inbuf_xlat)
> +		    == -EAGAIN) {
> +			set_bit(PERF_CMD_SXLAT, &peer->sts);
> +			(void)queue_work(system_highpri_wq, &peer->service);
> +		}
> +	}
>  
>  	if (test_and_clear_bit(PERF_CMD_RXLAT, &peer->sts))
>  		perf_setup_outbuf(peer);
> 
