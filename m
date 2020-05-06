Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4828C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E6B2073A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7SCliGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgEFN50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725915AbgEFN50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:57:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F66BC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 06:57:26 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so2767358wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 06:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9xxwlHsLDdr/018bY2TiA68tltVHydrJNhbqNoXLbaU=;
        b=Y7SCliGwj7h20Gk7fJZNp6xUGHU7EDL4FWzGSnxo+G9pSsXIMlhbCq68+JvrrXamOw
         TMQ1VnHoUAOFPBZXAJZ3RUuV6G28rlc1koZMvkLlRfiNHoT1WQdeD+mQwlYVJMelaP4d
         vbG44T7/5OJfdOM6zzRl20AsLk95UkoDQ+ClE2YJxAq7gAHs5tMx1dTGqExoFoz0hrwp
         Kjc1141FsXnu0jlcqG02VzoKefaenvBRpcfqxAZuKrmUS0VLJZ7a3DHJJkSTXDQtsrtB
         LZz3AKHpzjQ6SkBPDoNAoxH3cMjjg5e3qZRSkPYvrWuu/APxBTHPeb6q3oQrbrynGc0B
         GRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xxwlHsLDdr/018bY2TiA68tltVHydrJNhbqNoXLbaU=;
        b=QdOMa+/7ORvVlzBU9UjGsz4XBz7wn3zVCqMUpmBPh2+AZ4tTa86yzS3oOTYAkxz9Mg
         p2BiC+C8v5+PjS7ZWOahz5QS4WbA1mOqvy5ewkvVDKBgDLRleiybz5HF/mhrliYOXMda
         fuPHbRZq6QGsk/jIszkW2wMB8siFzuMaUoV1+uF14C6217Dk2fcHO6Uyzd78klaCcbxm
         Zrc/zH4pCdvqE4zTQhTlIuG6HG+4k/b4HXeRJa9nE0Y1gZMM2lUBhXG5C5UwU68Xtbly
         hR8diURAWPRbOml0szRW2DJBfUxCsDAEzPTDjFqpdDzaYpV9rr65SQ8RTxJktS0chE2Q
         0eAg==
X-Gm-Message-State: AGi0PuY4i1mejILgRv+xsGy0Qf9Y9JIcgePK/2MPDH+7l/HZEMuvAX+h
        y1yqhBCFBJsR+vc5j5KNCxZlqq+O+pn/T476baY=
X-Google-Smtp-Source: APiQypL4VMesTiDq72ToI4nwLD5vOm5Ct5PCWh8/QsIaVoqZt2Pa79HPIBdIn5d5JI0xhmKj/3R4YfIJLPBbDORQQ8A=
X-Received: by 2002:a1c:e087:: with SMTP id x129mr4704771wmg.127.1588773444883;
 Wed, 06 May 2020 06:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200504190227.18269-1-david@redhat.com> <20200504190227.18269-2-david@redhat.com>
In-Reply-To: <20200504190227.18269-2-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 6 May 2020 15:57:13 +0200
Message-ID: <CAM9Jb+hni2G69n5djfY7mqFALhk9QxGgyr1dkkGx4VTJLmhGGQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm/memory_hotplug: Introduce add_memory_device_managed()
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm@lists.01.org, kexec@lists.infradead.org,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
