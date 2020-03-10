Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D720C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA2B20727
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bxsFlD2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgCJKQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:16:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38400 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgCJKQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:16:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AA3KbQ123070;
        Tue, 10 Mar 2020 10:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8yfan1bd/za3N2T0k61dXu/OQgJK78QBAAl8NAlRa9k=;
 b=bxsFlD2WSUPNWlbzmjYnQ1lHF4rghmoy7ggPC9alSrQMk977SyDPocK83A9P5b6WNYFh
 4aRr9Stf+hdp0Nh4U+7q+6rH6wR09qtBaeApee80zIdaSg3HUjhI5RlhU6SVDfo4NW2Y
 eDmk1pv2bKtYJOnTFO5xzcJyLPypd16iAP+YlTevUxcDM65DDwda95cMD1k3DzJR8vKw
 1jKn0amo9G4/BXwE4TfsJ1mt98mvYtZhUEjZzliT/2V8CgENFVp3Rfx++MBuW/UvlVLv
 hMCfwEXvMPAN6WYivKJml+QuSU+ZeywcFEfAV/FONFXKLCLwdEiL2PEYpOwbALKEPsdb ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2yp7hm115a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 10:15:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AACni7041312;
        Tue, 10 Mar 2020 10:15:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2yp8nru26p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 10:15:35 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02AAFY7o010570;
        Tue, 10 Mar 2020 10:15:34 GMT
Received: from [192.168.8.5] (/213.41.92.70)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 03:15:34 -0700
Subject: Re: [patch part-II V2 02/13] x86/entry: Mark enter_from_user_mode()
 notrace and NOKPROBE
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20200308222359.370649591@linutronix.de>
 <20200308222609.125574449@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <b41b4b04-8d9a-2859-44fb-a9353c83f55e@oracle.com>
Date:   Tue, 10 Mar 2020 11:15:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200308222609.125574449@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/8/20 11:24 PM, Thomas Gleixner wrote:
> Both the callers in the low level ASM code and __context_tracking_exit()
> which is invoked from enter_from_user_mode() via user_exit_irqoff() are
> marked NOKPROBE. Allowing enter_from_user_mode() to be probed is
> inconsistent at best.
> 
> Aside of that while function tracing per se is safe the function trace
> entry/exit points can be used via BPF as well which is not safe to use
> before context tracking has reached CONTEXT_KERNEL and adjusted RCU.
> 
> Mark it notrace and NOKROBE.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/common.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)


Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -40,11 +40,12 @@
>   
>   #ifdef CONFIG_CONTEXT_TRACKING
>   /* Called on entry from user mode with IRQs off. */
> -__visible inline void enter_from_user_mode(void)
> +__visible inline notrace void enter_from_user_mode(void)
>   {
>   	CT_WARN_ON(ct_state() != CONTEXT_USER);
>   	user_exit_irqoff();
>   }
> +NOKPROBE_SYMBOL(enter_from_user_mode);
>   #else
>   static inline void enter_from_user_mode(void) {}
>   #endif
> 
