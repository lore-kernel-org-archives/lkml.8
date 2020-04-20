Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8962C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 02:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3DAB20936
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 02:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WZTr54ni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgDTCHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 22:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725953AbgDTCHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 22:07:23 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB9DC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 19:07:23 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 20so9031200qkl.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 19:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yqjihutydDvQo11dTTaNbqLtFlhQeTAYw+F5rbSQSTA=;
        b=WZTr54niV8KeWypn7ohk85mM+004n48qWbS3qzgRnG4uRgWPrUgAS9R9KMuerDsyrW
         S1V9BI7cHOyWWxkUWIt5vexMXgGCK2phpmXMEqCt5O3epB7fFPwJtCAq2vl8eP0xZjY/
         qilgCSpIjU8OcSqzleGt1xR8TB75YHaWU7TtU6nvSxATYbE85F/M2LzxNYT5eeRkM0PE
         5Zm4ZOw5nEhy3UOMiDrXIlgHp+FyNXVNWoMhKNOu1sAgFfgz72TRLrSseL7F24ttDKZW
         Xy4x9BB+2FlnhPmVzsjQY+wT2bvk2GA00rR7aVjyRkJR+EoWjz1eT+H7IErIP/qGZz+/
         PBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yqjihutydDvQo11dTTaNbqLtFlhQeTAYw+F5rbSQSTA=;
        b=Jzf6uqXSPz4Wa9BTn4M0iZjB1a8Soy9kym0wftJGtxcZYCPiPq0qeCjzArubDzxUNh
         QVKpxFVzwzbdxl8Yv5gN2m9L+dI/KhA/bQowxJDdvJQ6b8qvX0hfnA9GV+sjEiKO+pUX
         vjYk+7yy1lP5/pRs5YJfO0JINA/34N+8FZ2nPuGDHVEnOPdNounOZ8R9vlMKm+J9FN6K
         QdIMIt3C+2b5GfyEp81Kb2/qovi74lEOz+MbG4rW5DHuWyCpAH9IRa7kUY0prhTUhmIt
         4wUpVKeFjEHISZuQhhSi0jIHaDBiQayG7qszRFG4tahNwTG5eM40afF8t1rTV4nHoHkU
         nh4Q==
X-Gm-Message-State: AGi0PuZzE95EHpbs79HfNc8R9e5BfjrVV5GlqT7vJRuwzPh9XP8tqNRn
        Rjq77ZVyZhcKJXOCJ0Z8FGcxnJ5nc7X9oA==
X-Google-Smtp-Source: APiQypLgQElZuN6XHG32UaZDzLy9QHj15+TowgyKg8sizZ9OTdaCKxTJpslCMyzP0V4aUbsgYyQKew==
X-Received: by 2002:a37:4d5:: with SMTP id 204mr14240558qke.176.1587348442429;
        Sun, 19 Apr 2020 19:07:22 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v27sm14242935qtb.35.2020.04.19.19.07.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 19:07:21 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200418183429.GH21900@8bytes.org>
Date:   Sun, 19 Apr 2020 22:07:19 -0400
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3733C20F-46C0-4C4F-9E37-94D361377D51@lca.pw>
References: <20200418121022.GA6113@8bytes.org>
 <57CBF6B2-4745-4E36-9AA5-7E0876E3DA8F@lca.pw>
 <20200418183429.GH21900@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 18, 2020, at 2:34 PM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> On Sat, Apr 18, 2020 at 09:01:35AM -0400, Qian Cai wrote:
>> Hard to tell without testing further. I=E2=80=99ll leave that =
optimization in
>> the future, and focus on fixing those races first.
>=20
> Yeah right, we should fix the existing races first before introducing
> new ones ;)
>=20
> Btw, THANKS A LOT for tracking down all these race condition bugs, I =
am
> not even remotely able to trigger them with the hardware I have =
around.
>=20
> I did some hacking and the attached diff shows how I think this race
> condition needs to be fixed. I boot-tested this fix on-top of =
v5.7-rc1,
> but did no further testing. Can you test it please?

Sure, give it a few days to see if it could survive.=
