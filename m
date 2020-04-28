Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E127EC83003
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 02:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC4220728
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 02:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ZRkzebef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgD1CLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 22:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD1CLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 22:11:15 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66F5C03C1A9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 19:11:15 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s63so20348520qke.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 19:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=7634cSYNnkEeZLF9qaQ+2AgpibDUSOrBUl4aX1MYmtc=;
        b=ZRkzebefYI8C8YM+yiMqJuIxbcoHVPnVIoxvoL8/hgvaR74uXvHOvFl4346qeUIuUr
         7GZbXnz+22W3LePUoSJ2gWqSXyMqfX1aUWsfxdOmpYbgkh8OzGZ3kG4YzmdclLPek/RO
         oVJAxqoWqeclY26sXJcQs4W2JfjNzlx4Ey0FoMnFAYL9UxTnrZyoZzIjUm4gp+ozkZZB
         vFMTJiTsxGPCrFmtoqo4y0cxos0KVXLX5nMiiWNh/Qy+CCpNKygxhfkIy3hgeOu7PyAq
         oi2Y0OKlopHWpUuBSkiL0Ed0d0RcX12M4Hl2WS0lsStn0GM0VeqsPhoQqU3g67mlydnw
         wclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=7634cSYNnkEeZLF9qaQ+2AgpibDUSOrBUl4aX1MYmtc=;
        b=KLKKX5JwpjsnreWvLhq+O7RwARIenpnvT9V9+KaPGmgbU6kQaL0Y3Y14AU/R4MS2Rg
         8azu9M+QHr+lWd4lxR8mvBiazKaBUCTbUVwuYlnxHRSUFbHcWgNhQPDArgG72LAlbHvy
         eak5Ofxgx6hv7Il1NbNZ7GzwGq9l2tDHZUvjfSu1la2H6/lSN9SF8jd+KQsSk/g56K9i
         f2dqMkUwQ+pYgjvv7LVQQBnN/PagxGjtigKAPD7bl5IrHc6hpgIpLN7T879rSC01P6UY
         J4MF6gl/mhNjFxfh/LW4DbIp5qYxUpkidZdHR97ggoSEc94/YHQpf97+20NAFAkzaDLw
         q+ow==
X-Gm-Message-State: AGi0PuYmGblgik3PaT9eDDP+xiwq5Zn9GDlNkdXgMwuu5dsR0GXNrr4+
        Yo+Ym7+XTA9stg6QXxv6YD9zLA==
X-Google-Smtp-Source: APiQypLaVm9c2SWLzE0Ol8tWHv9xAxVvSk0tUEaXh6snUiBA0tr0lAOAwF/hn7HoXTPC1RAWydrxSw==
X-Received: by 2002:a05:620a:13eb:: with SMTP id h11mr23839919qkl.404.1588039874792;
        Mon, 27 Apr 2020 19:11:14 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p2sm12282513qkm.65.2020.04.27.19.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 19:11:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 4/4] mm/slub: Fix sysfs shrink circular locking dependency
Date:   Mon, 27 Apr 2020 22:11:13 -0400
Message-Id: <28BB8A1C-CFDF-4F5A-8686-537C3CE04818@lca.pw>
References: <dbbfe685-7374-9a96-b7c2-684142746e30@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
In-Reply-To: <dbbfe685-7374-9a96-b7c2-684142746e30@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 27, 2020, at 9:39 PM, Waiman Long <longman@redhat.com> wrote:
>=20
> The sequence that was prevented by this patch is "kn->count --> mem_hotplu=
g_lock.rwsem". This sequence isn't directly in the splat. Once this link is b=
roken, the 3-lock circular loop cannot be formed. Maybe I should modify the c=
ommit log to make this point more clear.

I don=E2=80=99t know what you are talking about. Once trylock succeed once, y=
ou will have kn->count =E2=80=94> cpu/memory_hotplug_lock.=
