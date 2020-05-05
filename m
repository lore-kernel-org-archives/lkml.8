Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B78C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D6A20836
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588694376;
	bh=cP3UEBEa5suVXBDnPY1BXFWQaRZ3+4arDZzJ8zryHFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BRQYQGSeMV07hgyrSb+VNMywQePsz27vMgHEssKNIT206hpDAk2Vuq9hbImRYMiNr
	 ZYCZna6GnsdUI5AuFMaEM0j8OYCPr66898lxFxkklJuxctGY4N2Lf2OG1FV/sdYQi+
	 b/Vz0g7PB97NKGd7o4YxzEFtETB+2ltJEzhphQE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbgEEP7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729553AbgEEP7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:59:35 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC779C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:59:34 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g16so2337938qtp.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mlbcxYsaznb+hn7swQs5FVbakMzUr9pQcmmIpCMzvXY=;
        b=qDYySwONS2reyob68C3mPjRUaOHJHLSGZbi8Gzoa+LcWu14ZkrkqwKc5LBPLCrKG9R
         kND2cPHGv56R3Akhy1ThZtAP0OYTR39ZCU/x+bw8czIZgOg9vcE3t7MAUCKE45V/dPqM
         ZPm0GVQw63bcdFfU165JbY9nrD9zor02tEpyZuNFrydBh18UjJD21+ajEfuxsVPpgXFZ
         jSALbgz1sORMvuuMVScIQlIN9p2A2zDqILgsmTYpq9bsJD+D+5lrdV3SrtDqa++jHlxS
         ROTfOwm7TbONa4ggoexzo/1O3r7Se4ppBW5soOThguWPBs/xE14YLfDY8xpj4kFcc/51
         iUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mlbcxYsaznb+hn7swQs5FVbakMzUr9pQcmmIpCMzvXY=;
        b=SAW1MbXMbPu/1Bv5vsdornLcTLzFDUg2SGJLmGTw5NlBDOn5/x8faRce22nsJ7Ja5M
         MjFwfGA5p69hjn5vFm7r5+B/1Cr3AdtzDcKrwYhvmVzpUK7G4RLv9vm4NFye9iV97jIh
         tR+5eMIFf3mM44I9eAkyz8GTpYGOFiLzbc5SKBOWT05g1eUXef57lrV/l9Ah9kLj1cuR
         TbOA9+G16fUSu23My3hoWN3oEtiEG5GJJN+7jdMkc/k3AJtO3uT0VuckF4ONqRUNVM70
         MF23QYCuktEs4obd9Bpd6CJSCyIt/Ud4nu4K50wsI5xNxfSFz9UkRkMTF/akBMohhFIi
         7L3g==
X-Gm-Message-State: AGi0PubXwCyzQWWozD1oGcVF8m9vcwxG3vEnZQH7jz7at/QSM1neMyI3
        cToXTDVFImJJEJSBW3Mqxu4=
X-Google-Smtp-Source: APiQypI+EoWLSDyAz8C0JbBp70IMWSs6yP86mjhgB9nCJrgran2afHcytLOCb0QUoqCfP+uGL1MN9Q==
X-Received: by 2002:ac8:6043:: with SMTP id k3mr2992359qtm.99.1588694374076;
        Tue, 05 May 2020 08:59:34 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:5ece])
        by smtp.gmail.com with ESMTPSA id o201sm2119941qke.31.2020.05.05.08.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 08:59:33 -0700 (PDT)
Date:   Tue, 5 May 2020 11:59:32 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        "Tobin C . Harding" <tobin@kernel.org>
Subject: Re: [PATCH v3 19/19] tools/cgroup: add memcg_slabinfo.py tool
Message-ID: <20200505155932.GF12217@mtj.thefacebook.com>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-20-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422204708.2176080-20-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 01:47:08PM -0700, Roman Gushchin wrote:
> Add a drgn-based tool to display slab information for a given memcg.
> Can replace cgroup v1 memory.kmem.slabinfo interface on cgroup v2,
> but in a more flexiable way.
> 
> Currently supports only SLUB configuration, but SLAB can be trivially
> added later.
...
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Tobin C. Harding <tobin@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
