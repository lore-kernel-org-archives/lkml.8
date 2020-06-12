Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2EEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66A7720663
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="g8x5pOxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgFLVc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 17:32:27 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:10212 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbgFLVc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 17:32:26 -0400
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CLMkHv010651;
        Fri, 12 Jun 2020 22:31:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=8YjJ+EG/ArDx72uGKi/SZPalo5BZh6e7LKJGLQxAyJk=;
 b=g8x5pOxYqYCqOGpvaYfrENaK4TWnJuc9f3lxY0DcHcU1x4fxfpsBb63AUlOOO+sCz8Cv
 boEwKc4sfBB/5bTXcdTOancpgp6kPr2gOWYk4/pw1aX3nysF2mLSA37kok7wKuPbbVTt
 NUErRrOUGCdoMnT3xOKjKVZmLNJZcfK/HBOdAUHRuGp8jemCS02J0+O91erREN/NxrUD
 p3Q0joOHhguDXaAyUI/hktdyS/AGO3UC/ZbIaPZaZbOxMnLZLg05g4Oaj8gEeqYntjmU
 frSZkrFtR+5NrIs45PhPpjFQ5ASNYMymsSAiGFzoUswpEb4uQFF8ZlDzLqACrYmxa/7+ 2Q== 
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 31j2dsthdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 22:31:23 +0100
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
        by prod-mail-ppoint6.akamai.com (8.16.0.42/8.16.0.42) with SMTP id 05CLKCwo013695;
        Fri, 12 Jun 2020 17:31:22 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint6.akamai.com with ESMTP id 31g6fxdadm-1;
        Fri, 12 Jun 2020 17:31:22 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 25C4939EBD;
        Fri, 12 Jun 2020 21:31:22 +0000 (GMT)
Subject: Re: [PATCH 00/16] dynamic_debug: cleanups, 2 features
To:     Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk
References: <20200605162645.289174-1-jim.cromie@gmail.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <8f106309-8d7b-5bfc-6f8b-7223a3a1c72c@akamai.com>
Date:   Fri, 12 Jun 2020 17:31:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605162645.289174-1-jim.cromie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-12_17:2020-06-12,2020-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120157
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-12_17:2020-06-12,2020-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 adultscore=0 cotscore=-2147483648 spamscore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006120157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/20 12:26 PM, Jim Cromie wrote:
> Patchset starts with 7 "cleanups";
> - it changes section name from vague "__verbose" to "__dyndbg"
> - cleaner docs, drop obsolete comment & useless debug prints, refine
>   verbosity, fix a BUG_ON, ram reporting miscounts.
> 
> It adds a few query parsing conveniences;
> accept combined file:line & file:func forms
> 
>   file inode.c:100-200		# file & line-range
>   file inode.c:start_*		# file & function
>

So I like the shortened notation there.

> Then it expands flags:
> 
> Adds 'u' user flag, allowing user to compose an arbitrary set of
> callsites by marking them with 'u', without altering current
> print-modifying flags.
> 
> Adds 'PFMLTU' flags, which negate their lower-case counterparts.
> 
> Extends flags-spec with filter-flags, which select callsites for
> modification based upon their current flags.  This lets user activate
> the set of callsites marked with 'u' in a batch.
> 
>   echo 'u+p' > control
> 

I'm wondering if users are really going to use these and how much they
simplify things? Do you find them useful while debugging issues?

Especially now that now that we are looking to let people define
groupings.

Thanks,

-Jason
