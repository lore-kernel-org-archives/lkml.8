Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDD5C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3854E20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jwuit2Wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDTQ4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:56:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38546 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgDTQ4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:56:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03KGqSwL127873;
        Mon, 20 Apr 2020 16:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=4mKzoX4/hY3C6irQ/jmYhVambJWyHyxunlU5OXOqWDM=;
 b=Jwuit2WxrefHp7o8LoegYgEqIpAU76XwvJdOr6noOXmSeqLJbY2N0Xv9hRvPupknWoZr
 Gx47Iv7KZlrex1uxtaLdKWY+ohCkxofna3RmNloHSkNrnPXSZrs0a1fjF1d1ceQaVzaM
 ygQByQY20Wxu4mjkJ2RBw/Ksx26yYV/7urqeOv+thlsx60+QWbN8czNt5w1UE+7C+T8Z
 ENFQO8D2CQCCFpOx4KjuT11Gs3zdGpm94IWOC5+/YlaeOXiE9CgSuf+n0d/JGHJXQJoW
 AeWW6aNmvLmEwzAFB4IKjICmPzdocYumNaCgsKo2oHAz2e4xeIircB4Ik71G4Iu+Pr5v 0A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30ft6n0e7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 16:56:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03KGq9op118516;
        Mon, 20 Apr 2020 16:54:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30gb1dmg85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 16:54:18 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03KGsGIH031641;
        Mon, 20 Apr 2020 16:54:16 GMT
Received: from linux-1.home (/92.157.36.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Apr 2020 09:54:16 -0700
Subject: Re: [patch 00/15] x86/tlb: Unexport per-CPU tlbstate
To:     Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20200419203137.214111265@linutronix.de>
 <20200420092045.GC24518@infradead.org>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <913b9a53-1df4-e371-a3d8-867d1242c341@oracle.com>
Date:   Mon, 20 Apr 2020 18:58:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420092045.GC24518@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9597 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=504 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004200137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9597 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 mlxlogscore=568 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/20/20 11:20 AM, Christoph Hellwig wrote:
> Just looking over some exports at the end of the series (and thus
> ignoring bisection issues):
> 
>   - Is there any good reason to keep __flush_tlb_all inline vs moving it
>     out of line and kill the flush_tlb_local and flush_tlb_global exports.
>     Also there is just a single modular users in SVM, I wonder if there is
>     any way to get rid of that one as well.
> 
> Also I think cpu_tlbstate itself could be marked static in tlb.c with
> a few more changes, I wonder if would be worth it?
> 

For Address Space Isolation (ASI), I was planning on storing the ASI session
into cpu_tlbstate (https://lkml.org/lkml/2020/2/26/699) as the ASI session
then provides the TLB flushing information based on the ASI used. In that case,
I would need cpu_tlbstate to be non-static. Otherwise I can have my own percpu
asi_session structures, but using cpu_tlbstate seemed more appropriate to me.
This is opened for discussion; for now, I am waiting for more changes that tglx
is making, before rebasing ASI.

alex.
