Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_RHS_DOB autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FD3C33CAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 21:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B3C206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 21:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZilIjmdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgASVha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 16:37:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38669 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgASVh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 16:37:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so27612326wrh.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 13:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0yhhLXZWkRk22XCrsnN5/sGz8BVyOku48FOhAd8M19E=;
        b=ZilIjmdGKlTBSKD2ob0un1zakRrRgVplMpo0B/sQQIAGqoEvZUebSTcQ2LvAZFjt5W
         nYJhriaohtYHJZAgTandTFoP4GCe94hUmAedCefa7AaHnNIDjuXIIS5tzjv+3Zlu4072
         ErbP9PGhaM7WQTlQZy1q7eyQQdJ9e05Oaw6bD/PFxzG7sa0iTuOFdgSpBsAgTxBVH4Nw
         BNnNqp2mxeKKK1J4V2Ph9xkVKQGWVU8plYoD0IMMI8wz32yGiD94Cy2stls9KjLvcDPN
         0galiqBfMAxhnWXsCyA6DBJ16WDgwkIjQ/OAATjhzJCA7K2Pr3Baaf3vjIZHdUw6QQON
         tJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yhhLXZWkRk22XCrsnN5/sGz8BVyOku48FOhAd8M19E=;
        b=j+cZwVxqi9UkPiv8X60BQvlxdfCEsgOkN/RZCpGcr/dBDfqPRvAs59c1f6MuE5KI88
         QueCqxtl8Fw2ccHmqWGOJZRQosGjg6Hh1MHxJda3/MFluwMAJJsTGz6HmsEDtT2OUhT+
         kvdAa6HKTahW8id3z1fDo+xZ1dRKDyRE/9CA3I9xa548yCz4Q16A5i2Gu1zbsXN6Lru5
         uuHHPytQVhiq5XyOouDJ0imlgDtYYueN4sK3jr//GGXriMTk4eft3yTElfTn0Xa0Y5Fa
         5hiaX8vVCD0RebDeLnaeJbnwnzHt63bX6f8U8L7e1+Ao4heTeNKa8/4nMt02DiqXfA0t
         fEGw==
X-Gm-Message-State: APjAAAXl4Xj2+aj1zorvwpMUyJxyx+GtRVCwgGllO2AmKs7XE7IN80nc
        9r61Xq90itlD8GWPqWu4YVNU4OMNQaYT8bpW/Eo=
X-Google-Smtp-Source: APXvYqwh50xTgDkYTgfH1G8mBb8ofLWObUuuYR1bGi1/0n3HtKI2N78Fl9Pxbnx17MhZXbHgwZyZwUf4fSSsyDlbTNE=
X-Received: by 2002:a5d:6441:: with SMTP id d1mr14390186wrw.93.1579469848014;
 Sun, 19 Jan 2020 13:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20191210223403.244842-1-brendanhiggins@google.com>
In-Reply-To: <20191210223403.244842-1-brendanhiggins@google.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 19 Jan 2020 22:37:17 +0100
Message-ID: <CAFLxGvwHALbhE8XVWCijx25n-LpysYR=fH6WnHADn_=c_BZqow@mail.gmail.com>
Subject: Re: [PATCH v1] um: drivers: mark non-vector net transports as obsolete
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        davidgow@google.com, linux-um <linux-um@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Berg, Johannes" <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 11:34 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> UML_NET_VECTOR now supports filters compiled with pcap outside of UML;
> it also supports: EoGRE, EoL2TPv3, RAW (+/- BPF), TAP and BESS.
>
> While vector drivers are not 1:1 replacements for the existing drivers,
> you can achieve the same topologies and the same connectivity at much
> higher performance (2.5 to 9 Gbit on mid-range Ryzen desktop) - the old
> drivers test out in the 500Mbit range on the same hardware.
>
> For all these reasons, the non-vector based transports are now
> unnecessary, and some, most notably pcap and vde are maintenance
> burdens. Thus, it makes sense to at least start thinking about removing
> the non-vector transports, so for now, mark them as obsolete.
>
> Link: https://lore.kernel.org/lkml/15f048d3-07ab-61c1-c6e0-0712e626dd33@cambridgegreys.com/T/#u
> Suggested-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>
> I pretty much stole the commit message from Anton's comments in the
> above link. Anton, if you would like me to credit you as a co-developer,
> feel free to respond with the tags and I will include them on the next
> revision.
>
> ---
>  arch/um/drivers/Kconfig | 81 +++++++++++++++++++++--------------------
>  1 file changed, 41 insertions(+), 40 deletions(-)

Applied. Thanks.

-- 
Thanks,
//richard
