Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4870C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B4042078C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBrSiIXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgEOIxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727116AbgEOIxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:53:14 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19816C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:53:14 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id z6so285047ooz.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dPqMiI17LOUe2nKh0vdLBm3601Jfamy6/fV1SlLaYgs=;
        b=lBrSiIXHPPzqbQXkQfMzB4upzKLZwIfjYe3KXVYeeYOku2ihD1cIyXITPTc463DnhK
         kpzSUi/+CaynNnMyOl3yQnf7TdGJ8qSiUDxrRxdmVdfIh+l2vcbJ3exWnZo6rEJHbvfE
         xczw8lYq7b4VcW7ZN2GuX91TJvka1HmFx7r7QDM/NXBzNIpBWCJPEypk+KIQfeA/G/Er
         nI/HxwRHXloYhThPaBdV/UaNr/wf9LZbhygIERuwcD0YEDDBXS7eD+jpq0uNztkBfgq8
         a87ryFCBz1ULAnCJYLEgz+Z7SUS6+4OUGF7Dymo0ckjKFQDeZ8f1JSE384ncQC3VDtzf
         noNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dPqMiI17LOUe2nKh0vdLBm3601Jfamy6/fV1SlLaYgs=;
        b=KiEaEPuM/WsXlkZUM7KVyUgbTwnNcbOAbPfi0JHbK1rA0+UmCeqxKeU9YTWw3V37mX
         sUrxWq3VkwU50I+dTl6VaWT4JaGbYGI3jYor4Yve+vFzIeGmeZQbZwMZbXyIw+qA/nRQ
         3oodU2GtfA7yS1kiNBgh3Ql/HtADcURK1RfnpXZd97T79TRyQA0SUlj6CYUdaBWuZdL7
         miuq2WBwikxzOXDpTRok0AbU1E/b+2kaWuIpi6lAysC5rK+kEMc9qvMa0M80R+70PYF5
         5acZiU5O8+h6T6rtlGjwY+iudmH7JqmRbjSPoKDmV2usoTMyfZ2vW0yhryBc9evUvTCB
         NDTg==
X-Gm-Message-State: AOAM533JpPRsXLldnAV/BhuN9a9uGKDgp+sL+/I8ZpzhfcM82I4aVFze
        BbrIMIbg0/LVq4HfvnHjKfUu42p2fP4qCTZwjZvfkA==
X-Google-Smtp-Source: ABdhPJyfvXUA8lQ8XP5wykD/if2cBbfoaZJWEKhUEomcApBXwi9LlIMUwePsKHZppv0vzHh+EVrb+lvApcU1PMkJJyQ=
X-Received: by 2002:a4a:615d:: with SMTP id u29mr1649801ooe.15.1589532793051;
 Fri, 15 May 2020 01:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200515053500.215929-1-saravanak@google.com>
In-Reply-To: <20200515053500.215929-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 15 May 2020 01:52:37 -0700
Message-ID: <CAGETcx-7qnNXug4PGssdXciy0BZrspXP0njJG+GFGFgie_Dwnw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Optimize fw_devlink parsing
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ji Luo <ji.luo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 10:35 PM Saravana Kannan <saravanak@google.com> wrote:
>
> When fw_devlink is enabled on hardware with a large number of device
> tree nodes, the initial device addition done in
> of_platform_default_populate_init() can be very inefficient. This is
> because most devices will fail to find all their suppliers when they are
> added and will keep trying to parse their device tree nodes and link to
> any newly added devices
>
> This was an item on my TODO list that I'm finally getting around to. On
> hardware I'm testing on, this saved 1.216 _seconds_!

Correction. It went from 1.216 _seconds_ to 61 _milliseconds_! So
about 95% reduction in time.

-Saravana
