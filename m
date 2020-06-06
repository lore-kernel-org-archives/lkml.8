Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFD8C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C53207F7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="aj1QcmnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgFFOhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 10:37:09 -0400
Received: from sonic312-23.consmr.mail.gq1.yahoo.com ([98.137.69.204]:44407
        "EHLO sonic312-23.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726340AbgFFOhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1591454226; bh=qaqF6Rrc7BFkCaJu4Wlhw/SUbONSZUkTwp66TO2xEfI=; h=Date:From:To:Cc:Subject:In-Reply-To:References:From:Subject; b=aj1QcmnXfKKE5YovxlGnLyRraZpQ9cYQo94JweSkhjElAvb06ciCOmnX4jwrrdxun7A2E3Ay5QXw0+EhPpHuS0oTedL0vCZTfLsnOMYskX5cQqFJhhxfXJJlIUDDlzpVKTFoantOVpRLgZMJKQradkpnQ2ZBW+A2IYm/4SUEiIVwSxbGTtGQ/v5l4Lw6Qi4QCRAZFu0ZVKOF49qeMUXyGfqypzMa5p86ip/3SYMyCGwTP857eUvyqp3Nx53qF8b7SvFPpEeIxx/dTQ+T5p8AixkduTXGBf3za/hcnNygCO/Ct0BXzq1vWLC2Oupd66cU5KfNtPb2oAfByJA8T+pVXQ==
X-YMail-OSG: kfFK5GQVM1mnuhY5DTVDh.Rv6Q0R6hX.dCWmi_uDH8..B5l1eKG1HTLXVlUve0b
 94evMK5m4D1ASBUVY7nurwoEqR47W1JKCRQd3S5.pr6Us7yN8fx.lAp7U3_TU.YwyUTlj6aZu1L9
 rRb9SeFzodoJruCs.r4GrCL2GugNtqkpaQCiiIHQU7f.AHW.nSbS6GSpOl_CKeibnyG9l2qqiYix
 6fg1jz8ptsZudanH9hC8WZ9q16wxRuLQAPsjq_qY7ECJY6o0drF_7VoPv6zS_i9wVeXjHi9oMcyq
 eKyKbYEeYL7q6SqQw6GTUJshmcyGR2PHGAk07DzaUfOGEp8d3RLIxqR04GuJPxmbS.8yCskfdaba
 lT6mvzB5EK1VrLCJMKN8b4VerH2v2JvP_LzZ8IPSuKbCEDpQ29DZBiht6ihZxZd40HLkfoeHTYSb
 W78n6es71X3zHYU7RU2I_45Due3twL8JRotYRwX1nWj.0mO2xOwh6jATnJPqnrVOPFel8dVK1NQj
 mvzT0tIR2io3BDHaVpFI_zBvjiEp0PI.HSM9SDpMd7CBn8zrRskCzYnwbBHtOcyE5biqw9Ycdx8N
 MS03_eD5lzXIB8Nu2.1c7KKAGJIAKEMo8XPTb6LyudAio0.CanpUtFiVYXvPd7oDVLXPFJhLSMsL
 QjXL9e64Vvu8E7MbG7Sqvzd.QzW3dUfnvrj82mdUrvpT37Q.A14DOrpPgra_vbdkvAPR_3qcVBKb
 qq4bIDiBKv2k953U3gEW0JYN_CO8avnJU4N.v1mkA1CoQPkI4Xuc3wnPFaZdEPOSQdOD0M2xGDao
 f0OSofj3CR6DM8KjbNyx5MNtRpcUPG2njgFc21w2_8M36s2EBd7WksVK6PnjltUwgzLzs8DzNzEZ
 K9GYZ4nhauc_Ik8T4OWFvk2lwDNv6DzCSI9vBQLC89.2OGUwHLkxcbqZtOUSk.d6mtuKM_OSwm5R
 Edwwyv1uWhj8dqnrSEM5nRSI0.DMptFP5PpMFzht448FyHUudk0mJDKcnyy_B8nx8eIg_Z79Nl.f
 acdGmIvDqGeTakxer7eyMypkWEQshxOw6NbW3W2qvxhkvmnpjYHl.XF6fhH8ku7MREKzpLQuSPpo
 b.1GkZtmWwShl1RzmhVQAl7dh1oJkyW2_sQvDdXe.8svjFVjWGtociPZxrKkdXgRuMSFUoeVBiaR
 Qpoo7cviEZe_6gC4jZ.4XVWev7Fgo.q2NjP9l9gizvavhNbKBwcGoKxMwMl55QT2OE6hUFieejKN
 432bVwgjRwRkq1fwfklMicweprizVmVz0vRIL_AZlL1KSOye_xvymB9qZeA011wwypK3c3ckNYVy
 Gnz2g76KA5JWnV1aj0Sl1Ex2e_pSw5.JslRfWIX6LsVOZ1ocqaeZmaTWU8LWgIkkqjAQG9Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Sat, 6 Jun 2020 14:37:06 +0000
Received: by smtp425.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0571a4f7d2a72a46ce0f757b81ae3129;
          Sat, 06 Jun 2020 14:37:02 +0000 (UTC)
Date:   Sat, 6 Jun 2020 22:36:47 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH] lib/lz4: smatch warning in LZ4_decompress_generic()
Message-ID: <20200606143646.GB10839@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e109dba0-eaa8-aa21-3b97-f999c76a72a4@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
References: <20200606143646.GB10839.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
X-Mailer: WebService/1.1.16072 hermes_aol Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm not sure whether my email was finally sent out since
 I haven't seen it in lore yet. Resend with my another email...)

On Sat, Jun 06, 2020 at 04:28:02PM +0300, Vasily Averin wrote:
> Found by smatch:
> lib/lz4/lz4_decompress.c:150 LZ4_decompress_generic() warn: maybe use && instead of &
> It was realy incorrectly copied from
> https://github.com/lz4/lz4/commit/45f8603aae389d34c689d3ff7427b314071ccd2c
> line 1431

Simply no.

> 
> Fixes: 2209fda323e2 ("lib/lz4: update LZ4 decompressor module")
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  lib/lz4/lz4_decompress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
> index 0c9d3ad..f7f7dca 100644
> --- a/lib/lz4/lz4_decompress.c
> +++ b/lib/lz4/lz4_decompress.c
> @@ -147,7 +147,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
>  		    * strictly "less than" on input, to re-enter
>  		    * the loop with at least one byte
>  		    */
> -		   && likely((endOnInput ? ip < shortiend : 1) &
> +		   && likely((endOnInput ? ip < shortiend : 1) &&

I'd like to say, this is not my mistake (even not an issue).
If you notice the latest LZ4 upstream
https://github.com/lz4/lz4/blob/dev/lib/lz4.c#L1865

Or some related change, the lz4 author Cyan did it on purpose.
https://github.com/lz4/lz4/commit/1a191b3f8d26b50a7c1d41590b529ec308d768cd

I think we could follow the latest LZ4 upstream in order to
avoid further maintainence overhead. That's my own thought
anyway.

Thanks,
Gao Xiang

