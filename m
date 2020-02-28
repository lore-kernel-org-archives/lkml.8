Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835FEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5866A246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MNHsXAsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgB1Jk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:40:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54734 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgB1Jk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:40:57 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01S9cnCf037227;
        Fri, 28 Feb 2020 09:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=oC8LNxmXglYwzvgGlDc1hT2k8z9I5gGZE4a9r1ALzhY=;
 b=MNHsXAscdeLgKirgKHZGaSKKRTD8TL3DDuIdl1AN+Um93TWQAfH+V1Tf4yZG0oTfEXkX
 p3nZjhGIYugFNm4OqiJbxWsJEuHxnGtCGVeY8F/MLDnFZ3ZiPJrQhrlGYB+TDShEbcOs
 Tf/Ug1LQ8qBV+zG1HbmfRSldigoO1H1LgolbCuZ7PJZbVbX9FTXOLi3pAyJNoXxHbxCg
 KDK2F0iw/cc35fFyl0vLLNg+STGfzpDpd8baImo9OUKefE51Q2acL2yRer6E0mPT+FBW
 eZpilczsqxm3xkphIdDLrYz4b2G4prhxAmJY6gSuIR8OYFwCo7SMcR/39cSteMb8MIKG uQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2yf0dm80cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 09:40:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01S9cFV1167311;
        Fri, 28 Feb 2020 09:40:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2ydj4q9r33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 09:40:15 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01S9eBgm022079;
        Fri, 28 Feb 2020 09:40:12 GMT
Received: from [10.39.209.75] (/10.39.209.75)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 01:40:11 -0800
Subject: Re: [patch 02/24] x86/entry/64: Avoid pointless code when
 CONTEXT_TRACKING=n
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225221606.511535280@linutronix.de>
 <20200225222648.395059616@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <b18b0575-c80e-4842-546a-83d7147bb809@oracle.com>
Date:   Fri, 28 Feb 2020 10:40:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200225222648.395059616@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/20 11:16 PM, Thomas Gleixner wrote:
> GAS cannot optimize out the test and conditional jump when context tracking
> is disabled and CALL_enter_from_user_mode is an empty macro.
> 
> Wrap it in #ifdeffery. Will go away once all this is moved to C.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/entry_64.S |    2 ++
>   1 file changed, 2 insertions(+)
> 

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

