Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAEFC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 22:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31BEE20838
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 22:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598047223;
	bh=npJ9JfiHw5QH+Te2YIwAPeb1lkoVMlxx/XvT49KT0yo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=z58c2aR3vWocM615XdSEtyVo1LBkzZw48jrlmQYLEBCATTCJ6ZwpWDIve7vMGDc+Z
	 1GpkVImsaLfTvhk0iCkE31y1MOjScnKlIvXww9Ko6ZLRTveII+3WfejN37GRNKbYW/
	 q5USlMTdvo582yk8ZZk8CpxjrCCNFcSHPfPGGmD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHUWAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 18:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgHUWAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 18:00:21 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1953207DE;
        Fri, 21 Aug 2020 22:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598047220;
        bh=npJ9JfiHw5QH+Te2YIwAPeb1lkoVMlxx/XvT49KT0yo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=swe9Kd5EDoGiNsI1ampcesKqQ/4qKOrNAjpAuvsodhpzGO59IBS+J5yuq+0sxbApe
         rY8yfbwd45BS+KbhBDnUK4SZGQZRe8q4EtdVfEYYYjm3IesxpV9jiE/qbegpNnBsR0
         aTuuPtlwL2XeoEUjDWPJPMmfoiy+jp2bTbg6RWGY=
Received: by mail-ot1-f51.google.com with SMTP id c4so2730414otf.12;
        Fri, 21 Aug 2020 15:00:20 -0700 (PDT)
X-Gm-Message-State: AOAM532q/e2fh4MsmHE+4MRzPzhWb8haTAkq0eLwS9/g3IpyT0q2S23v
        5HayaKlvsRXIr3yT6cUxtx91RP8NxCclVjZFdw==
X-Google-Smtp-Source: ABdhPJyzdb92OxG70pj0I2WhIHERgGCAewmxFodJiMtW/HEhpO7m/J7nacCNlJDQDFAYDGBfReme8jlvGsbEf9C2pJs=
X-Received: by 2002:a05:6830:1b79:: with SMTP id d25mr3196629ote.107.1598047220135;
 Fri, 21 Aug 2020 15:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <1597966267-33614-1-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1597966267-33614-1-git-send-email-f.fainelli@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 21 Aug 2020 16:00:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJQuBjNio37Mc1VPxmE-15Sy9qymR-T36=8wOOeoMYPgQ@mail.gmail.com>
Message-ID: <CAL_JsqJQuBjNio37Mc1VPxmE-15Sy9qymR-T36=8wOOeoMYPgQ@mail.gmail.com>
Subject: Re: [PATCH] of: Export of_node_ktype for modular use of of_init_node
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Grant Likely <grant.likely@linaro.org>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 5:31 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> To permit the use of of_init_node() by kernel modules, we must export
> of_node_ktype which is directly referenced by kobject_init() called from
> of_init_node() otherwise modules would be getting linking failures.

You mean of_node_init()?

There's not anything in the kernel using this that's a module. It's a
low level function that I don't really want to see more users for.

Rob
