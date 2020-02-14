Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D2DC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE22422314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ub5DLhf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgBNU1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:27:07 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35749 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgBNU1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:27:06 -0500
Received: by mail-pj1-f66.google.com with SMTP id q39so4388351pjc.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=czxoMUp3Pjr6uWl30+XgYiTPMamH2WNKAnbDK7ZYNkM=;
        b=Ub5DLhf3/WmhWpRD19QBpvDnnh0by0GhwvdVweClIoIlf6baJCbEBgS4tyoGJjn9XZ
         mBwyJj9bx+lOQOQkK9XCLOaxv0zqKTusmBbIvvmUc0RfJ4twQVFOXyQn4s5xcsxchuLg
         1OlMtsFrCxdvTQz2NCIEjEFzUojZLOJM6joyc780Lnw2hmDMcQJ+4THY23jQ4Sk5ogi1
         3YV4gsLDAJDcPvSkFTJvvs3nJ4yk8ekXYndFZwOLcEHZwrv6ekcWbzKzGJt+NLCdtbXs
         5FdOPuO/x3UU9/ZGWFEIv9k2Y5PgvVY9UvMreqbQfG87o2yOZMafAGFE/7LNoN/+UsMa
         N2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=czxoMUp3Pjr6uWl30+XgYiTPMamH2WNKAnbDK7ZYNkM=;
        b=HSFr5erkyioZWzRau+jZ3gBMFjHQ32wXA2Bx3xNwJZPU0b+HzeUiUNYVqXW6RNxlt/
         YPlHipF2MQ/8/0OfeCT58vjPor+Wkv+gMblgmme4JdjDeiBq3o5epUzuF9WVCM9F5quo
         5E4PGdnmV7R55vCql9ZuwNDRKSKXixUkzGfaqGgzW+oQt4Ul9pyL1oUbWZLhWgTnnsnh
         QF5jz6imn4WjQIsj/GYEtHiotN9RfILKEbC17RbTUoMEGajc+8RuRCnI56FVGBICcuAs
         1nSbcAdus0t4MHcomkMTRV/2qM8g7ex0l/pgBVvVAChV6LzxA9mS6ZuOZxqzuQzQJ+Pe
         ISnA==
X-Gm-Message-State: APjAAAV3U8cFcpax2AsFjKATruxvqEArowhCSFAyzdZoMjfsvwvPEaxi
        Cl3UtMzdxxQNZwpHlwENgVIbYw==
X-Google-Smtp-Source: APXvYqy72UJxqIvKWL9AS0WJAIH8fvTUPVquZUEHCVsPv5uPL8cLKuuWzB1wbvUpQNWn8R9vvggvJQ==
X-Received: by 2002:a17:902:aa96:: with SMTP id d22mr4956986plr.204.1581712024558;
        Fri, 14 Feb 2020 12:27:04 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id t28sm8076954pfq.122.2020.02.14.12.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:27:03 -0800 (PST)
Date:   Fri, 14 Feb 2020 12:27:03 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     minchan@kernel.org, anshuman.khandual@arm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: replace open codings to NUMA_NO_NODE
In-Reply-To: <1581568298-45317-1-git-send-email-yang.shi@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.2002141226540.241404@chino.kir.corp.google.com>
References: <1581568298-45317-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2020, Yang Shi wrote:

> The commit 98fa15f34cb3 ("mm: replace all open encodings for
> NUMA_NO_NODE") did the replacement across the kernel tree, but we got
> some more in vmscan.c since then.
> 
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Acked-by: David Rientjes <rientjes@google.com>
