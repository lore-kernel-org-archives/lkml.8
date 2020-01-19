Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CDEC33CAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 22:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B67220678
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 22:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KiX394NO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgASWHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 17:07:06 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54373 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbgASWHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 17:07:06 -0500
Received: by mail-pj1-f68.google.com with SMTP id kx11so5791211pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 14:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=BYSZ9xL7TDf1GtsTEJ0J+4ZhcMv2ysvRekB03PSrVjA=;
        b=KiX394NOsv6PYmkqMGRP8Iik46YtKfb8doeMTrf/BVT3oFFOM4u8bJk1e3ELke+0rD
         fgK1nYDu3Cj6IoItqC7F24ChzoDAFnDFljOqnkAPbkrJrw1BBqbFN4TgHj4FmWJCshbY
         M9GxKmwx1zC8UM/HTEquW9iK4qTruYsm5kF8lu2HvORL/BsGNA9H2NV+YpBY0NSVTiqj
         1/+na3yFhuUGb6l6r9qPy15UrVanBVKXjgWgCHMhrz2VcWu515skvqhNqgTVR0Qfziqs
         gC0lSmlFBMNV6wimpG4vdNQG64zDDnWfVNHwf+kWO/gNgGBaYWesb+t81G5ih8EkNvDk
         xLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=BYSZ9xL7TDf1GtsTEJ0J+4ZhcMv2ysvRekB03PSrVjA=;
        b=q2PefOmJX3ld5ERCexvmtBBkU74vS9NO+PHDLRT0DJqHrwmFv5ACouDqlB1ajYEHyy
         HR/DKpoEi1y8liOvx9y/LEEz2HjfRIa+mO44YMC058BJ2MrbYz2c/HFqplYAz1DqNE1t
         uFygxe/1+oCqe5s55b+9X7ztJvBsDO3D6b9zBljd3iP0UGMMNx8C/jJdYDnCNnG224aF
         2GQ3gJjkxkrfgxRZh9ki0JzgdGBvW9ucwfhnhOHy1j/0DUdVsGyjfsv38cDT/eFP1gRg
         2D3pEjRP3M1w2UWYd2A9WYgbvMZFp10je8LfA+/jSP7SP0JCXh0oBOlpGq80PimhllKx
         px/Q==
X-Gm-Message-State: APjAAAVEGu2zg8EvW1IloHoLFFbiMbfhNeEcRCXUdlpOzP+i4W3723Fv
        RK6mxFeZJ39OR9Mtij2J4WV3HtIiAkY=
X-Google-Smtp-Source: APXvYqwin6w7xMhaXzu3lBVjsk4UjhRMm0Gqr4sF7q2o+Hs9Xk66ge4fLKqUjk2khoVIvcUptGTEYA==
X-Received: by 2002:a17:90a:246d:: with SMTP id h100mr19167208pje.127.1579471625391;
        Sun, 19 Jan 2020 14:07:05 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z22sm37095796pfr.83.2020.01.19.14.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 14:07:04 -0800 (PST)
Date:   Sun, 19 Jan 2020 14:07:04 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Wei Yang <richardw.yang@linux.intel.com>
cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/page_alloc.c: rename free_pages_check_bad() to
 check_free_page_bad()
In-Reply-To: <20200119131408.23247-3-richardw.yang@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2001191406270.43388@chino.kir.corp.google.com>
References: <20200119131408.23247-1-richardw.yang@linux.intel.com> <20200119131408.23247-3-richardw.yang@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jan 2020, Wei Yang wrote:

> free_pages_check_bad() is the counterpart of check_new_page_bad(), while
> their naming convention is a little different.
> 
> Use verb at first and singular form.
> 

I think if you agree with the suggestion in patch 1/4 to fix the issue 
with bad page reporting that it would likely be better to fold patches 2 
and 3 into that change.
