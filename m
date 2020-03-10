Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67049C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF9D20637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BpLElkmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgCJNtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:49:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33612 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgCJNtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:49:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ADgSm1171180;
        Tue, 10 Mar 2020 13:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=nhgz/w5Eb5VDZMZsWlI17qnMWK+YUGYFeu4ia0BfkhY=;
 b=BpLElkmdo0xPUf2HP1thsvg9AgngLdlVJd9D2GykXlinSUiQ390bHEjwnaOReuQj6/Bv
 Z1AtAdgqwGQi3irEA/UyjZV3HFXbvSXBXEP89dvj8ubVQn3XGsmA+8w1gGTf4JnvDP5u
 jKTubLBHekzRKCmayVFJQgMuVNK9GcvaNnqMWIAYUF4PUxslcpYfDUas9d+BX2rzLU1n
 68lK2zFIZECCB19jG/MLFRNDCZg3wFKO3dAHBgJzt1zvospUkAy7B34OzojzT+HGO3oD
 +PVMhE52PzmqZzYbG+g+5G0dJd8ey8ISbPV6xL6suEDVEjNMGinwdtABhse+oxDiTxXb gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2yp9v60qau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 13:48:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ADhUdg171181;
        Tue, 10 Mar 2020 13:48:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2yp8rj07gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 13:48:34 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02ADmXok023293;
        Tue, 10 Mar 2020 13:48:33 GMT
Received: from [192.168.8.5] (/213.41.92.70)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 06:48:32 -0700
Subject: Re: [patch part-II V2 11/13] x86/speculation/mds: Mark
 mds_user_clear_cpu_buffers() __always_inline
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20200308222359.370649591@linutronix.de>
 <20200308222610.040107039@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <c9847c45-32b0-e5e6-1eb9-5f9e10814276@oracle.com>
Date:   Tue, 10 Mar 2020 14:48:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200308222610.040107039@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/8/20 11:24 PM, Thomas Gleixner wrote:
> Prevent the compiler from uninlining and creating traceable/probable
> functions as this is invoked _after_ context tracking switched to
> CONTEXT_USER and rcu idle.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/include/asm/nospec-branch.h |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -319,7 +319,7 @@ DECLARE_STATIC_KEY_FALSE(mds_idle_clear)
>    * combination with microcode which triggers a CPU buffer flush when the
>    * instruction is executed.
>    */
> -static inline void mds_clear_cpu_buffers(void)
> +static __always_inline void mds_clear_cpu_buffers(void)
>   {
>   	static const u16 ds = __KERNEL_DS;
>   
> @@ -340,7 +340,7 @@ static inline void mds_clear_cpu_buffers
>    *
>    * Clear CPU buffers if the corresponding static key is enabled
>    */
> -static inline void mds_user_clear_cpu_buffers(void)
> +static __always_inline void mds_user_clear_cpu_buffers(void)
>   {
>   	if (static_branch_likely(&mds_user_clear))
>   		mds_clear_cpu_buffers();
> 

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

I am just wondering if it would be worth defining a new function attribute to
identify functions which shouldn't be trace/probe more clearly. For example:

#define no_trace_and_probe __always_inline

static no_trace_and_probe void mds_user_clear_cpu_buffers(void)
{
         ...
}

I am just concerned that overtime we might forgot that a function is defined
__always_inline just because it shouldn't be traced/probed.

alex.
