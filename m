Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D02C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E62EF206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="CuqD0EC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgGXNs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgGXNs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:48:59 -0400
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084ADC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:48:58 -0700 (PDT)
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06ODkonD028542;
        Fri, 24 Jul 2020 14:48:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=CJWtpA97PzfgL3vYNZn173kkDIA2105N3wLY59om3KI=;
 b=CuqD0EC5nx4xGwirwEAACm4VUEgWRT8nhY/lNbnNs5i6Qwvd+kbPCniqyDhl1ROvwyYu
 iycoYcgUgaTI1AZ7ySX6e4ep8u64b68znXJRVndmf31f1omni2pRCTrVkVw0K5ac/BOa
 fgOfxjKJ/sgjRRvGYb1lBYv7VyGYZw8GNMaXfNMnJFgTmx33MYadvXkguLd3MsmZUlk/
 iEgRBe2GZ55hTf2Rwhoqq0FcIfqUWeYR/YD5fJ8E/F12RyWdgHcBPKoaimP84Bf1Wh3k
 KPaa+qBYvIC1LncSpPnnt0jruDUtzDbCdg6rEvDFXWWled1CCGVFPXCkrovL/E0qUpDO WQ== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 32bs7j28bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 14:48:55 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.42/8.16.0.42) with SMTP id 06ODZD4B008291;
        Fri, 24 Jul 2020 09:48:54 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint1.akamai.com with ESMTP id 32dn7xw8u5-1;
        Fri, 24 Jul 2020 09:48:54 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 3E9383F7B4;
        Fri, 24 Jul 2020 13:48:54 +0000 (GMT)
Subject: Re: [PATCH v5 00/18] dynamic_debug fixes, cleanups, features, export
To:     Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk
References: <20200719231058.1586423-1-jim.cromie@gmail.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <4d7244b1-fa4d-f1bd-42e4-7123116e708f@akamai.com>
Date:   Fri, 24 Jul 2020 09:48:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200719231058.1586423-1-jim.cromie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_04:2020-07-24,2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240105
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_04:2020-07-24,2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/20 7:10 PM, Jim Cromie wrote:
> this is v5, changes from previous:
>  - moved a chunk from patch 13 to 12, per Jason
>  - shorten logging prefix to "dyndbg", drop __func__
>  - now with more commit-log advocacy
>  - shuffle EXPORT_GPL(ddebug_exec_queries) last.
>  - v4+ series Acked-by: jbaron@akamai.com

Yes, series looks good to me:
Acked-by: <jbaron@akamai.com>

Greg, what do you think about pulling in this series?

Thanks,

-Jason

> 
> v4: https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_lkml_20200620180643.887546-2D1-2Djim.cromie-40gmail.com_&d=DwIDAg&c=96ZbZZcaMF4w0F4jpN6LZg&r=1fLh1mlLqbfetnnGsbwXfpwmGlG4m83mXgtV4vZ1B1A&m=Fx_Nr_SBO_RxVITjMD8U8davIy4lmiMx9iQ0RiHncbw&s=Yk6jd9kp4ASId49a5PYXxFrYDDDw8eD595yeyH8JOrU&e= 
> v3: https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_lkml_20200617162536.611386-2D1-2Djim.cromie-40gmail.com_&d=DwIDAg&c=96ZbZZcaMF4w0F4jpN6LZg&r=1fLh1mlLqbfetnnGsbwXfpwmGlG4m83mXgtV4vZ1B1A&m=Fx_Nr_SBO_RxVITjMD8U8davIy4lmiMx9iQ0RiHncbw&s=fwZUOLHfC4rKPBAanu69vs_StJyGBUag2iMQm7l9k5s&e= 
> v2: https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_lkml_20200613155738.2249399-2D1-2Djim.cromie-40gmail.com_&d=DwIDAg&c=96ZbZZcaMF4w0F4jpN6LZg&r=1fLh1mlLqbfetnnGsbwXfpwmGlG4m83mXgtV4vZ1B1A&m=Fx_Nr_SBO_RxVITjMD8U8davIy4lmiMx9iQ0RiHncbw&s=Xwb7nTFjQ7rmEnEQXARt_J5EV8Jy2lRMq4PiKKBfWeE&e= 
> v1: https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_lkml_20200605162645.289174-2D1-2Djim.cromie-40gmail.com_&d=DwIDAg&c=96ZbZZcaMF4w0F4jpN6LZg&r=1fLh1mlLqbfetnnGsbwXfpwmGlG4m83mXgtV4vZ1B1A&m=Fx_Nr_SBO_RxVITjMD8U8davIy4lmiMx9iQ0RiHncbw&s=09pJ7MRxLOyDjzN2yYYEOrqP0HtPJZPWLL9rVhKj1EI&e= 
> 
> 
> Patchset starts with cleanups;
>  - change section name from vague "__verbose" to specific "__dyndbg"
>  - cleaner docs, drop obsolete comment & useless debug prints,
>  - refine verbose/debug logging
>  - fix a BUG_ON, ram reporting miscounts. etc..
> 
> Then adds query parsing conveniences
>  - allow "file inode.c:100-200"		# combined file & line-range
>  - allow "file inode.c:start_*"		# file & function
>  - accept "module=foo" query form
> 
> internal improvement
>  - combine flags & mask in a struct, clean 3 func interfaces with it.
>  
> make precise format queries easier
>  - accept "format=^ClassString" anchored query
> 
> finally, EXPORT_GPL(ddebug_exec_queries)
> 
> This gives module authors complete run-time control over all their
> *pr_debug* callsites (when CONFIG_DYNAMIC_DEBUG=y).
> 
> Following the drm.debug UI model, drm.debug_chan2 could be wired to a
> callback which invokes ddebug_exec_queries to toggle arbitary groups
> of pr_debug callsites.
> 
> Useful callsite groups would exploit existing message-prefix
> classifcation schemes:
> 
>   "format=^[IF_TRACE]: +p; format=^[SURFACE]: +p" >control
> 
> 
> Jim Cromie (18):
>   dyndbg-docs: eschew file /full/path query in docs
>   dyndbg-docs: initialization is done early, not arch
>   dyndbg: drop obsolete comment on ddebug_proc_open
>   dyndbg: refine debug verbosity; 1 is basic, 2 more chatty
>   dyndbg: rename __verbose section to __dyndbg
>   dyndbg: fix overcounting of ram used by dyndbg
>   dyndbg: fix a BUG_ON in ddebug_describe_flags
>   dyndbg: fix pr_err with empty string
>   dyndbg: prefer declarative init in caller, to memset in callee
>   dyndbg: make ddebug_tables list LIFO for add/remove_module
>   dyndbg: use gcc ?: to reduce word count
>   dyndbg: refactor parse_linerange out of ddebug_parse_query
>   dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'
>   dyndbg: accept query terms like file=bar and module=foo
>   dyndbg: combine flags & mask into a struct, simplify with it
>   dyndbg: allow anchored match on format query term
>   dyndbg: shorten our logging prefix, drop __func__
>   dyndbg: export ddebug_exec_queries
> 
>  .../admin-guide/dynamic-debug-howto.rst       |  29 +-
>  include/asm-generic/vmlinux.lds.h             |   6 +-
>  include/linux/dynamic_debug.h                 |   4 +-
>  kernel/module.c                               |   2 +-
>  lib/dynamic_debug.c                           | 269 ++++++++++--------
>  5 files changed, 173 insertions(+), 137 deletions(-)
> 
