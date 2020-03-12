Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FE8C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9341920716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="qaWsULht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgCLRdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:33:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37103 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgCLRdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:33:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id 6so8569901wre.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 10:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NoiaqPMaLbyoL7WcV9VE9eKkmobOKnQ4L0s3bngIbSs=;
        b=qaWsULht3bWoY5iXQLEcDGdBTFV6hjN7lpV33RTCtB3xWc1PLX/WRxZQohX8Xrl/9w
         UmohlrmtFgTmdaoEpFrPYYLSu55234z8uvo9TnjcyiBJbYmm2fJpmw10ZPHUC3T9G4Z3
         CvKX3yFDACoE48iNQsDgNcSOYv8fqeVuxR4Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NoiaqPMaLbyoL7WcV9VE9eKkmobOKnQ4L0s3bngIbSs=;
        b=ibI9CdG6yv3Q0RXmYAewOoaejTfVNoN1evjlZL8tMFC4JHyLWtL9xP1+odwNZT1bzf
         9CBahXpXC9uV9ENeazj91BgRB/mYmZqbKLXhoaA3hJBEQ+rqE9A/ZN24GBZ2p+e8jV9F
         gHz7rtsKOSG2ACE7bil62Y8R3y6g9aCbGgCFeSRdwM12Me6UBtiIRmM1fnxCDf9sRGb9
         TV3t2y6FG+5fX/H1GRyWYcGjlhqzsbOc9uXSt6BC9TkmKUnA4u9YJ1rTmH+0D8DsP7WO
         pQUH1lpSKc0kByKBFToh6SbviNRUC7FfU5Y0SbXuQh60yJe9K5lsvJvOnXmFZEzjO4Tk
         enxw==
X-Gm-Message-State: ANhLgQ3qJ44MqJ4RKXINhFmp7XDwtwfud/65UBz2Aphj8OjlkDiVSmyY
        en2AVKIB5By8WJ2BAaiD6KR4cg==
X-Google-Smtp-Source: ADFU+vvYbyeKzXBtFBZm5+Qqw3wXcJUdTLliut8wUu0quaYaNk9IXP08ecLQIM8cttCro0Cmn5Mn+Q==
X-Received: by 2002:a5d:63c7:: with SMTP id c7mr11956491wrw.384.1584034396977;
        Thu, 12 Mar 2020 10:33:16 -0700 (PDT)
Received: from localhost ([89.32.122.5])
        by smtp.gmail.com with ESMTPSA id o3sm14396506wme.36.2020.03.12.10.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:33:16 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:33:16 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 6/6] mm, memcg: Prevent mem_cgroup_protected store tearing
Message-ID: <d1e9fbc0379fe8db475d82c8b6fbe048876e12ae.1584034301.git.chris@chrisdown.name>
References: <cover.1584034301.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584034301.git.chris@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The read side of this is all protected, but we can still tear if
multiple iterations of mem_cgroup_protected are going at the same time.

There's some intentional racing in mem_cgroup_protected which is ok, but
load/store tearing should be avoided.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 57048a38c75d..e9af606238ab 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6301,8 +6301,8 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	}
 
 exit:
-	memcg->memory.emin = emin;
-	memcg->memory.elow = elow;
+	WRITE_ONCE(memcg->memory.emin, emin);
+	WRITE_ONCE(memcg->memory.elow, elow);
 
 	if (usage <= emin)
 		return MEMCG_PROT_MIN;
-- 
2.25.1

