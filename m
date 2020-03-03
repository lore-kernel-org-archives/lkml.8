Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA03FC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F30820870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uuswdbwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbgCCVK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:10:57 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43038 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730925AbgCCVK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 16:10:56 -0500
Received: by mail-yw1-f67.google.com with SMTP id p69so77327ywh.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 13:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jhw2/hBTqqb08+XbLqFc1lQG7+XacrKgacG+f+lhHlw=;
        b=UuswdbwtGUq/KOpTGPSUcHmuRFxUeMPpUUcP4c3+mgsuAAZ1wqfnSivQRMp7zhqP2i
         yvBWIw6bqMhNA/DPbB71aQ0wCjAsjDNSGE4vvK+62X9DlD438J/f+Nj2df/aPLkpKMfF
         5ocn7OG+YEKPkfrWpPgr+GcwXyvyAQ/mWC5rmoLddKOt9BLvUI7SMHMb7Fw9CVC1Brwp
         7oBlwlgyME+tIP2gNltFHprtxkzqmd46EM7RAj60QXtKXqz8qLiEzu7thzKr+f14dQCa
         wqB5jjXoBB8PCTZRigPCyuFoqbQRvn1jgnb6lYeX9vn9ADIMgGrH9qfcDDR7AZ4WBOg6
         zscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jhw2/hBTqqb08+XbLqFc1lQG7+XacrKgacG+f+lhHlw=;
        b=hfPX5AZNfS+0EgdxriTPFvbnQ3F0kvaVAFafjh80cUSn2cLWNWHT05C3/EQxINaZG4
         C4+gFbBhnr5cKmtm6etBmgrMhzGb/JRXMpgNpmjAueX5ZXp4wnQvYqQbA1aY7PT3Xx4I
         9obaVEcPHEw13ZB3zx/z+IFVNaZ9p1xnM8K+F/FFSyP4tisAE2fwhNA3EcDWtP2oOC/y
         kVTEMaiAFB+Ztbe4WQB+4cDkxvjIjduG3jWS47FNdrQ3hLjlomry5tSzr9RGKTMb5Rfm
         eQIe3ObEBrZmfLcHVDp2BKrDwmka7e/e7IHFC/vMPQEG9mM+8y7u5Nq9ZyklFiU5Y3PY
         6nNQ==
X-Gm-Message-State: ANhLgQ1h36YkrIU1yWl8CyeGJTToiTUj2mmhbF0ovoJCzb1OGFeTZj75
        c+D/8jm3U/tD3mg8elYeD435zuB/
X-Google-Smtp-Source: ADFU+vsEbnSlM7oGL9DtebhjrJZii5EyJwKjrMBBftWbqqCUZqe3Ee6Wz+KeYqMy+vvlUWUZRKdcUQ==
X-Received: by 2002:a81:b627:: with SMTP id u39mr6618523ywh.180.1583269853034;
        Tue, 03 Mar 2020 13:10:53 -0800 (PST)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id d6sm4834539ywc.8.2020.03.03.13.10.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 13:10:52 -0800 (PST)
Received: by mail-yw1-f53.google.com with SMTP id 10so112412ywv.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 13:10:51 -0800 (PST)
X-Received: by 2002:a0d:d68d:: with SMTP id y135mr2472118ywd.117.1583269851243;
 Tue, 03 Mar 2020 13:10:51 -0800 (PST)
MIME-Version: 1.0
References: <20200228105435.75298-1-lrizzo@google.com> <20200228110043.2771fddb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CA+FuTSfd80pZroxtqZDsTeEz4FaronC=pdgjeaBBfYqqi5HiyQ@mail.gmail.com>
 <3c27d9c0-eb17-b20f-2d10-01f3bdf8c0d6@iogearbox.net> <20200303125020.2baef01b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200303125020.2baef01b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 3 Mar 2020 16:10:14 -0500
X-Gmail-Original-Message-ID: <CA+FuTSeL_psqzpB6hxSh6f1HnO_SrpED=71Y3HcyDweG2Y3sdg@mail.gmail.com>
Message-ID: <CA+FuTSeL_psqzpB6hxSh6f1HnO_SrpED=71Y3HcyDweG2Y3sdg@mail.gmail.com>
Subject: Re: [PATCH v4] netdev attribute to control xdpgeneric skb linearization
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Luigi Rizzo <lrizzo@google.com>,
        Network Development <netdev@vger.kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        David Miller <davem@davemloft.net>, hawk@kernel.org,
        "Jubran, Samih" <sameehj@amazon.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 3:50 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 3 Mar 2020 20:46:55 +0100 Daniel Borkmann wrote:
> > Thus, when the data/data_end test fails in generic XDP, the user can
> > call e.g. bpf_xdp_pull_data(xdp, 64) to make sure we pull in as much as
> > is needed w/o full linearization and once done the data/data_end can be
> > repeated to proceed. Native XDP will leave xdp->rxq->skb as NULL, but
> > later we could perhaps reuse the same bpf_xdp_pull_data() helper for
> > native with skb-less backing. Thoughts?

Something akin to pskb_may_pull sounds like a great solution to me.

Another approach would be a new xdp_action XDP_NEED_LINEARIZED that
causes the program to be restarted after linearization. But that is both
more expensive and less elegant.

Instead of a sysctl or device option, is this an optimization that
could be taken based on the program? Specifically, would XDP_FLAGS be
a path to pass a SUPPORT_SG flag along with the program? I'm not
entirely familiar with the XDP setup code, so this may be a totally
off. But from a quick read it seems like generic_xdp_install could
transfer such a flag to struct net_device.

> I'm curious why we consider a xdpgeneric-only addition. Is attaching
> a cls_bpf program noticeably slower than xdpgeneric?

This just should not be xdp*generic* only, but allow us to use any XDP
with large MTU sizes and without having to disable GRO. I'd still like a
way to be able to drop or modify packets before GRO, or to signal that
a type of packet should skip GRO.
