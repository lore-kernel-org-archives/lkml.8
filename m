Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B856C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69AA720728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m7cQip5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgDWTvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgDWTvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:51:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433F1C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:51:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id n24so2758136plp.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=5tWhbVu6f4kKLyjS9n2H+QKCL93se0wUZsp2GpUWnJ4=;
        b=m7cQip5KfL5HR2V+EKRyTtJ3V15ZC1ZrB+JdE6lRckcbhAabJIJ+UUe6I64yo+ozH5
         EQG0k8496luTp9MI9Li0rADkqs/km5SLwhpaU+BAdNVHYpIQYLYEIwPFjaph9xHsJOWE
         BgTuQ0YwTq1/tBizp9Nl5s9pArRuB/vwdOxTBzFObX0rtnqxB8dGBIhl6MqIf/YIrC77
         CKKEnLOMT7ZSckHWfHVg+ezljF9qKyFk7xekfawD/2rQqFLOSQ2jjjNXvAbTHzjoVl9M
         wajheHzMpnV4daW0yYGoPmE3lBlxJx5zGGung8mzQ3NiPju4cVJcNt2SSXrhyIVozMRJ
         KCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=5tWhbVu6f4kKLyjS9n2H+QKCL93se0wUZsp2GpUWnJ4=;
        b=Hc3NDtCvl1q/H2K3+JXbgIS01aXt1qjJIhmEDoNVZW0NbzJBwCuMN0RAAwMc4SWkKE
         zGa1+Efu6SyyRjc5UbnNOKVx3cnDrI1LLZNlqL5yKPeMell0V7H3USVrH1qr62f98bVz
         TuuWC1XJ16B7gcr6p4cH4v/dRMZoufON0sOJr/vteqzXG5LbO/F5RstMzSD7/25mf01S
         eyfHp+HDs9ib0spvnAe0m2Ls4A88rHzR44SR0FYCg5m0kXhR5jW3CTHHsMnLH7dCpsn9
         Bk1CPtExkJ6PLHrcejJcXMLmsDLQ4Q0MDJ9k4XTYLzZDt85hvf8sIfUuZxuihqXEdE9s
         PC7Q==
X-Gm-Message-State: AGi0PuawfbNKh+V8YOK3G+B2jopxPfvquQNIMjUeeCsw774f39cd+ezz
        jIBWx2PLTPjqTEqwI4xxtPgg3w==
X-Google-Smtp-Source: APiQypK0hnwQefSAK9l6B4HhbysWyTvs3gPGYwKSuX/g42JrBKE0CexKbHC60H8OhhX/8RCvfFCfiA==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr5107800plb.139.1587671462576;
        Thu, 23 Apr 2020 12:51:02 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id nm22sm2961544pjb.38.2020.04.23.12.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 12:51:01 -0700 (PDT)
Date:   Thu, 23 Apr 2020 12:51:00 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
cc:     akpm@linux-foundation.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mhocko@kernel.org,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] slub: Remove userspace notifier for cache
 add/remove
In-Reply-To: <20200423115721.19821-1-mkoutny@suse.com>
Message-ID: <alpine.DEB.2.22.394.2004231250480.248617@chino.kir.corp.google.com>
References: <20200423115721.19821-1-mkoutny@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1482994552-405825474-1587671461=:248617"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1482994552-405825474-1587671461=:248617
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 23 Apr 2020, Michal Koutný wrote:

> From: Christoph Lameter <cl@linux.com>
> 
> I came across some unnecessary uevents once again which reminded me
> this. The patch seems to be lost in the leaves of the original
> discussion [1], so resending.
> 
> [1] https://lore.kernel.org/r/alpine.DEB.2.21.2001281813130.745@www.lameter.com
> 
> 8<---
> Kmem caches are internal kernel structures so it is strange that
> userspace notifiers would be needed. And I am not aware of any use
> of these notifiers. These notifiers may just exist because in the
> initial slub release the sysfs code was copied from another
> subsystem.
> 
> Signed-off-by: Christoph Lameter <cl@linux.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Michal Koutný <mkoutny@suse.com>

Acked-by: David Rientjes <rientjes@google.com>
--1482994552-405825474-1587671461=:248617--
