Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4AEC433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3F502245B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgGNMks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:40:48 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:58969 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgGNMkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:40:47 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MWSJJ-1kOFtd0c7n-00Xu1w; Tue, 14 Jul 2020 14:40:46 +0200
Received: by mail-qk1-f174.google.com with SMTP id e13so15379526qkg.5;
        Tue, 14 Jul 2020 05:40:45 -0700 (PDT)
X-Gm-Message-State: AOAM532uWDfK0CrMGEqUt+3JEtNLskFiGnm5aWT4PyqG7lknZnW356qk
        xivRCE1zfxU1jA19LxwwobUqkniFpy0+80lXE8E=
X-Google-Smtp-Source: ABdhPJwoDyUVNvcOe+3WE/Iw422K5Ioay6giK+l3tMcD5he75L5Od52pooGlmGuC3YHnkuA463/el5XmyYtbmMe13MA=
X-Received: by 2002:a37:a282:: with SMTP id l124mr4103430qke.3.1594730444925;
 Tue, 14 Jul 2020 05:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200708175020.194436-1-daniele.alessandrelli@linux.intel.com>
In-Reply-To: <20200708175020.194436-1-daniele.alessandrelli@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Jul 2020 14:40:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3GVZftAZKEHC3TjDRL86vYOkND6TNuVq1KjssOHi5AXw@mail.gmail.com>
Message-ID: <CAK8P3a3GVZftAZKEHC3TjDRL86vYOkND6TNuVq1KjssOHi5AXw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add initial Keem Bay SoC / Board support
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
List-Id: <soc.lore.kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        DTML <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Paul Murphy <paul.j.murphy@intel.com>,
        Will Deacon <will@kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:CsynuHuwhHtu5uzF+9VYwHTOHeqJFWUP52MU5ctkAdvQyk183H6
 gZqqgMZU6MO6d4Sgt9Qi0sE2qHQLuOEqs8gFjdv9O+nL3qBGJ5iYOQ9undmjHTT2vdKHYUa
 nsQGaaF/O/iYZsiptdAqYvr4CVcvBsjC+m2sKBB0H7nq1+dAnWYeQXPopPew739thZsKqJz
 Rdc8csrJy1rU017s68Vqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kJyLWz3kEj4=:vOcnB8EFLlBnmYTTKTwQrM
 alOEZAeGQhQ2eyzA8c/HkD12ZTiKooAVcYD1iUveJLGorsAy0b/gEGhl7JCjSKl8BcU9INhuY
 VxKK+umsUS7bW0c3SyQ+AzKWfWTAEOy6JVJtwDN4TP21kf7k2eXY1zz6PmwKi1b+4EbN0NSty
 n+ZgalwffrzvMMH8eLGPZRonpagRwbd9MawsPAD9q6I5GGKVDjbeyCMhmL89F8KmYJx3Aw7oe
 Dzx20PVQHxJRJKAJex3YV0BBpoXfuTdVtuas/U76ZpQ6bZHj9fXWsrbOK3Qvfo3hEIfNhf3gl
 HA+uYJO2uiGupILeymREMXmmhARfThO9NCNE8WeOwzaSqefikPT4UnPDIau68s98CvO75FD6a
 ray6/ghyfmeQWRo2mU6wP3dhsPmQUVJxcfsLM/4A2rRRX2H0gp/WcwlrqBZ5VDzAQ1r8yKLMJ
 wQhKh7G359DX3n6pa2AZAdwDFipCRRdg0RuCmjgUpCNE4UBL2bxQ1WnTOj+yWfWOtp8B2YO3i
 lwf79W/+QSVWFeSLSnWueu9t297boVdHdKSh2q7xBvq0xecnMBLXp8DqQxLPnHKVRYin7jTXk
 o1rvvWrmLg6tja/n63gMPjO1zrWVy4IokizIHKQLrccmK9k19NJqnQ2pKya9TmO4CjsqMTaRq
 bY49eP8+tawnMRVoj7XYEu9H7rjEAaRJz2okswev9PL6XsUtv6SRN7nQ5qyp7DCWPkWvp1giN
 s62H/RYSXit5DP/xJs6wvTjhaPsesq7aqQ6OA2qXDCtUOcA82ymcb/7g2GzoXcF9H0uBE3HMz
 jaEVttUxJVay1TSNP94ogDOUVdK+PsiZOMes2Fa7g6WYVAfWC4IDkju7dFNO/SRGR9ilj45/Z
 NMXgPF4FY10aau3jnKUe3pcjAcZJVyEII5b7OxwTWEkiGhfnPHRW2VnQO777MwOyltsCGIO4A
 Rf49B42n+7U7tXHxqCN48ktluMOW7aOIaRBQNPEHCFohcUci4E3v3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 7:50 PM Daniele Alessandrelli
<daniele.alessandrelli@linux.intel.com> wrote:
>
> Hi,
>
> This patch-set adds initial support for a new Intel Movidius SoC code-named
> Keem Bay. The SoC couples an ARM Cortex A53 CPU with an Intel Movidius VPU.
>
> This initial patch-set enables only the minimal set of components required
> to make the Keem Bay EVM board boot into initramfs.
>
> Changes from v1 to v2:
> * Moved keembay-scmi-mailbox driver to a separate patchset
> * Removed Keem Bay SCMI mailbox and SCMI node from Keem Bay SoC device tree

This all looks basically ok, but I noticed that the DT bindings ands
DTS files all have a
"GPL-2.0-only" tag. Usually we make those dual-licensed in order to
make it easier
to distribute them with a non-GPL bootloader and synchronize them between
projects.

Do you know if the GPL-2.0-only part was picked intentionally, or if it can
be changed to dual-licensed?

      Arnd
