Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45ABC2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CD52080C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o9LayuFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgDCTly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:41:54 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55265 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgDCTly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:41:54 -0400
Received: by mail-pj1-f68.google.com with SMTP id np9so3448637pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 12:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=RbHDsHw524llOarwKUky8DPquFPK39k02zZxPLpgMOs=;
        b=o9LayuFgKoBojXjlwS/oiXjN8tTU2CWVtgI2vVG5IVreC6cv7JAJ814tPbdeVrolfv
         hP+EA9GQktkMzNRkdlIsKpuzGGCUI5Kmm42QkeskOcEUCj7J1mcceNaJ14haAl05k5gP
         ESQm83kGg1bqr463HiF/3yJrzScmhi96fkCiEyDeTVqJDsZToHzV6d4pmugDAV9Fa7Tw
         QwYHlTfpPd38vQjW3zP95Wg9Nis9KDvYfCyop5c9CNfIIKai8JxX/JOSjJp6/cdYktpt
         brfMrUAfcdXlbCqX7pvRr1XRuMNOwNyMtik5cl6tH2oUse/MCxQoA9h/mNAynTmT6V4Y
         zyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=RbHDsHw524llOarwKUky8DPquFPK39k02zZxPLpgMOs=;
        b=efTYyz+HpNTgZZ3fyagBFUzBRntyZ/IzDIScJXIN1epEQ1VEmafwIpfcRXAqQQjI+h
         HK/HA1c52cXxUKDmXhdN7owExPsF+7SJnpPCIbXGDl1LhKSWTE2DMag/FbKpQBrICoRP
         lut2JPmGuOalhdUkFuynFo8Rcdlwm95TUvBKs3JBtHbkBjoHsvz4k8REBPMNorPtAhxe
         cEbF1cJcfiXgfXQ1R3Vp2gEIMkfQtREbY4Mj3Ci8BCs28ZmTKS9XNwqnbUvFGkGuXHim
         f20T5f4x3zRuBNZhiB0In/ZpMs/y3X8ygxBPC0TvIzUqRIe5Y5Rut6VveoZi+lyx3wXh
         an6Q==
X-Gm-Message-State: AGi0Puasqp93teXW+a+5ZT62biqNJwLvaKM6M/MPw85PKqredH+tNuPg
        rXR8XLoTERsjNgQAKIQJROo5bQ==
X-Google-Smtp-Source: APiQypKLZQh9aewTTYEjX9w87lyllSCPeYXK9v837ePzcHyqrZQT06a1Ayvitx1lVTs0mEx+/fYg1g==
X-Received: by 2002:a17:90a:902:: with SMTP id n2mr11503771pjn.169.1585942912598;
        Fri, 03 Apr 2020 12:41:52 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id h34sm3131100pjb.47.2020.04.03.12.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 12:41:52 -0700 (PDT)
Date:   Fri, 3 Apr 2020 12:41:51 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Neil Brown <neilb@suse.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 2/2] mm: make it clear that gfp reclaim modifiers are
 valid only for sleepable allocations
In-Reply-To: <20200403083543.11552-3-mhocko@kernel.org>
Message-ID: <alpine.DEB.2.21.2004031241380.230548@chino.kir.corp.google.com>
References: <20200403083543.11552-1-mhocko@kernel.org> <20200403083543.11552-3-mhocko@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Apr 2020, Michal Hocko wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> While it might be really clear to MM developers that gfp reclaim
> modifiers are applicable only to sleepable allocations (those with
> __GFP_DIRECT_RECLAIM) it seems that actual users of the API are not
> always sure. Make it explicit that they are not applicable for
> GFP_NOWAIT or GFP_ATOMIC allocations which are the most commonly used
> non-sleepable allocation masks.
> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: David Rientjes <rientjes@google.com>
