Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B87C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 02:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA7C206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 02:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579228137;
	bh=xO8AhbNEFIGUiIn+HNFjYahs8bM8nhfuVM679xfZ2uQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TBaWV6Agox1ZoUjdgo4gnq9pXrLYL9ucbebkWnnsaoqx0mWMffprRKrnDhPMaVd3f
	 Jd/Ls6vx2985Hm5VTxQ3Wmtwg8Z2IkTyCBbaoSfUqDZmppGTANwQS+HmoGS1mZRy/1
	 fSJZukcdEFq1CXhwXO0TCiDd166vhqHVnfDOew6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388921AbgAQC24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 21:28:56 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:17483 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388334AbgAQC2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 21:28:55 -0500
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 00H2SZbI032140;
        Fri, 17 Jan 2020 11:28:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 00H2SZbI032140
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579228116;
        bh=hqIiFv0vlbk8v+McocbQfQ5XPxeoUcGd8URuFu7Q58Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UryCtISmpl6ZveBO5j2rBQqorginb3L64L2Dl8IzEG1fkHySHZYmgq8j5mcHAnW/u
         mqgLT6na5kDRgEzxtWXWYvJGdwAuNLwrbUKEFjiI2IV1T7vhZN9Tzk5jMm5PlGgEEo
         BK7ud2aq9T2CNt9qWankSN0dhJx8Ywp/1YQBVIc6k56fyOqJHHY4xs23+nnS/ZG74P
         kiNtcuz+nGTXkJd5n8+FIEWhx7y7RE3QQzU2lCJ849K++2VdQwIc1i4X2W5EjEBsLz
         Tj1eLac6/LgyLVY7qClcfW9VfnYtvliIz6MAF1X0+f2/CQ6QmSkpIzONYg2n1bCRFL
         Hv8Td0npQmZGw==
X-Nifty-SrcIP: [209.85.221.174]
Received: by mail-vk1-f174.google.com with SMTP id d17so6259178vke.5;
        Thu, 16 Jan 2020 18:28:35 -0800 (PST)
X-Gm-Message-State: APjAAAUJ3u+Oe4uYahJjvFP93wj0D1vtbfHT8HvxCf7M/E69vbiDt5rP
        g9bd3kBtnd7nZjY+ddAabouN2hqFnSFnmVe+CYU=
X-Google-Smtp-Source: APXvYqwWZbIDWqll+Cx58kBUpBqVexGuN4IKXN1PvpIpSjaTkK0d/oE+iO4nLo5BNsIrbQGNEZc/51CY2BPdQui+sH4=
X-Received: by 2002:a1f:252:: with SMTP id 79mr23167280vkc.96.1579228114985;
 Thu, 16 Jan 2020 18:28:34 -0800 (PST)
MIME-Version: 1.0
References: <20200113232212.138327-1-helgaas@kernel.org> <20200116125255.56eba406@lwn.net>
In-Reply-To: <20200116125255.56eba406@lwn.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 17 Jan 2020 11:27:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNARRg+DYRuRbbWMz+++BNhM==omTK26tTC1bBXQUNiMK9w@mail.gmail.com>
Message-ID: <CAK7LNARRg+DYRuRbbWMz+++BNhM==omTK26tTC1bBXQUNiMK9w@mail.gmail.com>
Subject: Re: [PATCH] kconfig: fix documentation typos
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 4:52 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Mon, 13 Jan 2020 17:22:11 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Fix a couple typos in kconfig-language documentation.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  Documentation/kbuild/kconfig-language.rst | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Looks good to me; Masahiro I assume you'll be taking this one?
>
> Thanks,
>
> jon


I can pick this up, but I commented on the first paragraph.

(I do not know what is the best way to describe the
plural form of a special keyword...)







--
Best Regards
Masahiro Yamada
