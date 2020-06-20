Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5D0C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593802468E
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592684289;
	bh=dmREjEvIjD2PEIQqGxiL3krYDQUiL8B5wfrUXPZbgyk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sVvun7p0SANj6lEAoKnGvX9pkp6F1o6nLkI/ZeV7WM8hLkJNeUFrvDnUf4/inTDBI
	 jsdzoFGQrP7AyxZWvrXttYo4fnsFNinDbfM0+rXq2I7J4w5C2rEx0Da6E5Xbo0vnOw
	 m3SGDNQ12uS/qGd3bmUfet3d5L7/crGH8T2G8Vu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgFTUSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 16:18:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38055 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgFTUSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 16:18:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id 9so15186065ljv.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DkO/cTikH1vCB4t/qMP7eJZkR4/mPqVASeuRmjb69mU=;
        b=Kh7dx19OmKwl7jADZ8zqbQ72gVJECSRzZuxCNb1HOfzHCYIcwXzQM3ZOnLJypzch1S
         RnBpRHTTxOmvzv0LGtXoW8/plid3ltSRe/SHFRwf6CoqguDTLALBUB/TwLd/Q992czri
         GHXjyh1IJ03YgfxQXcaVj3BK+o+fFLDwEUV9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DkO/cTikH1vCB4t/qMP7eJZkR4/mPqVASeuRmjb69mU=;
        b=t7MfmLSTq9GvLFEPZg6P0iBW5pWUmYI/0uHl0mL9x+MS+mkpP4L1vlpRPcdEo2yFD4
         5cYPLIORc2/gDghRceVlnobU2ftc0Q03yVu3IpfsgyWZwGSEAwFXUBZa0vrAN3EA3oG5
         n8g7ZmfuGsQOm3R9TCsivddg1Fe2iCpkWrmmErH4B13VVmrkdiLEXCeLAobgszgbPinh
         OK6cu58VM0zysTBm40j/I3pelvoIGFFhTaer9hvd4U85MGn4W+BKsCtUoM5SGKWHjJdP
         UDNY6pkBNwxUXRoVPoevjdhyAjMTwlmMOavVGRgK0KS2q1PqvTXAVzkxjXFUYoe2FC/w
         DC2g==
X-Gm-Message-State: AOAM5312S2zBFvyhHMG/CH576sPH05qU9+XUaGlHkYd0kasHXCwtSwDA
        5l5xyymcpVLHdYSvW6qCZ8dWkR7QWlI=
X-Google-Smtp-Source: ABdhPJyhADZlKc7yRwezl547weZ1OIciUm05iGd7SGsXko5Xwix59DjkbBuMAxSJrrCzF1+ghsr1sw==
X-Received: by 2002:a2e:1508:: with SMTP id s8mr4598381ljd.52.1592684224412;
        Sat, 20 Jun 2020 13:17:04 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id o19sm1832971ljc.23.2020.06.20.13.17.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 13:17:03 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id w15so7442807lfe.11
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 13:17:03 -0700 (PDT)
X-Received: by 2002:a19:8a07:: with SMTP id m7mr5381500lfd.31.1592684222742;
 Sat, 20 Jun 2020 13:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4jA-_Wd4S6gM2jf_VhVsgsdR5rQTeAc3AEPr6SAvhq3eA@mail.gmail.com>
In-Reply-To: <CAPcyv4jA-_Wd4S6gM2jf_VhVsgsdR5rQTeAc3AEPr6SAvhq3eA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Jun 2020 13:16:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whD8TDJyiGauFj4GQxvBoKPFQCbgBtDTj_6oAUWUYo-Ow@mail.gmail.com>
Message-ID: <CAHk-=whD8TDJyiGauFj4GQxvBoKPFQCbgBtDTj_6oAUWUYo-Ow@mail.gmail.com>
Subject: Re: [GIT PULL] libnvdimm for v5.8-rc2
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 3:07 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
>     These patches are tied to specific features that were committed to
>     customers in upcoming distros releases (RHEL and SLES) whose time-lines
>     are tied to 5.8 kernel release.

Ugh. I'd have much preferred to see this during the merge window, but
the code looks straightforward and harmless enough.

            Linus
