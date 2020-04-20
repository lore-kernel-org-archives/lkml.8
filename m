Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEF3C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14AD8206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0dASc/nX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDTQ3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:29:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42948 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgDTQ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:29:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03KGIRrK097179;
        Mon, 20 Apr 2020 16:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=vaowHN1wYK+HPlBhnAmToCjB2mfzdaKTJsxFeKtQV/w=;
 b=0dASc/nXEa8RpOpZQvXqmgXZXIEN6oc6b+2XX7OZFRB/ZBe6oSu84+c3XbxPG4jWlALT
 SIZG79KJDRBfyWMyLXx2V6IkiLBiLYpOfMgL0PKJxfNeNQA6fVxDgQMwwFSTJ7GIDVjI
 VGh/o+vBsQx4nInPwt0Xn67kwMH3GyknBMPHAwWmHhIa6yofIRIW16ttkRvOaKgRW/iA
 NzpUulDJvOdUOrclk19A80q31tNNzeOQL5KEalEG+SzVL0PEKAyw8NoiuW0zqWlj/zZc
 kpMsmwElf/uSRkd8ocql5imLV1G/NaUc9+JFYBDYAYuhhSsrTHPFRwNc0mZEsZ7NI2S6 pQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30grpgcs6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 16:29:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03KGCOeU051492;
        Mon, 20 Apr 2020 16:29:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30gbbb144c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 16:29:16 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03KGTF0w017518;
        Mon, 20 Apr 2020 16:29:15 GMT
Received: from linux-1.home (/92.157.36.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Apr 2020 09:29:15 -0700
Subject: Re: [patch 00/15] x86/tlb: Unexport per-CPU tlbstate
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20200419203137.214111265@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <860bf6a4-e0c9-92a8-065d-780f4a5794c1@oracle.com>
Date:   Mon, 20 Apr 2020 18:33:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200419203137.214111265@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9597 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=911 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9597 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=963 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004200133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/20 10:31 PM, Thomas Gleixner wrote:
> The per-CPU tlbstate contains sensitive information which should be really
> only accessible in core code. It is exported to modules because some inline
> functions which are required by KVM need access to it.
> 
> The following series creates regular exported functions for the few things
> which are needed by KVM and hides the struct definition and some low level
> helpers from modules.
> 
> The series is also available from git:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel x86/tlb
> 
> Thanks,
> 
> 	tglx
> 

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

For all patches.

alex.
