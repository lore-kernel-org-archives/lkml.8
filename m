Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F029C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 05:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D5720661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 05:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="YB4BUNeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgAaFOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 00:14:46 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33089 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgAaFOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 00:14:45 -0500
Received: by mail-oi1-f193.google.com with SMTP id q81so6174522oig.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 21:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PMcuS4LHry0i7DZ7ldtekzqzj8KrQxFLARw5rUFC3dY=;
        b=YB4BUNePIM6enPmASfYT3cwjHuMA+cOwjd5AU1JFMP5dn8Yq9YXqx0L53gjl6Gyzkl
         5kG1BNLepiYkWJbao814Aj5KzNKw/SxFciSCG9pAPQ1Vl31Lb+FRijSu2RlvWwqxmz1V
         t5OFCVsaMUxgTHH27jx3c7DfQTOYiNeCNZHhh4U1dkxfAuDoeJ0RoCD5pWybXaXBKCgR
         5lg6a4vN6IMCyAVqu8i3QQhIjzPPi0qOUgutCMcqCoyTr/+f3QgmReQ1QgRvUUQDoQAM
         nEeQT5nqUOxl1z7kuLI9kthwhBXP3Zyf9wOXQ/9C1+PkspbY4Qep23XKZEohNh4rbaAF
         79HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PMcuS4LHry0i7DZ7ldtekzqzj8KrQxFLARw5rUFC3dY=;
        b=GFnnt4tJK909RZRk1cxwd/YuYgW1N/eYc7mpx+MbiAWi06hm/ePPamfl/OcFqh7yAy
         R9Fnmjz3pqIbkMZWu51B3/H9RPtK/NVJDDNxaWT2+Euf92AcMRUFoWc0avfWzcjfRTcW
         nx0+VGOL9yv9SMj5Oig6jAo7H31Y+g9iOX7XzzdTiFO65VfNtpOvuAGPrGoZx6g/wjg2
         Ur1mcHEPOy+WJHQDTOt2RiSqRsHGuFUHHvXR1h8BrwUOF5vS8dJ/wMQysadkbKLs9MW3
         paJjKZjP0Lwp4JwXCRdob0O1HpUgrKUoW0HD9ZCfCrzW9CsLRHTTp5iBa4qEPA5IovI6
         Pn7A==
X-Gm-Message-State: APjAAAUi1TWQZyDQ66mApD6VwxOKYG4rTKoLgp4a4pFY6reX5PH2VGTz
        6RdtcYl6eEshCU8hoo3P6Wi81k+5RXq+KAa1QJJ68A==
X-Google-Smtp-Source: APXvYqxj9SjLEO7AhYfAHVo9xLBu9Nup8mW6BzzYMbNeUvMlioFhNe3oNXeD4an0sNTe/yFKjrfStHsB04BMKeaIBuc=
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr5446118oij.0.1580447684795;
 Thu, 30 Jan 2020 21:14:44 -0800 (PST)
MIME-Version: 1.0
References: <20191025044721.16617-1-alastair@au1.ibm.com> <20191025044721.16617-10-alastair@au1.ibm.com>
 <3ba57ce6-9135-0d83-b99d-1c5b0c744855@linux.ibm.com> <df24e47c2bd9472c7be06c6c266b2a250c30068f.camel@au1.ibm.com>
In-Reply-To: <df24e47c2bd9472c7be06c6c266b2a250c30068f.camel@au1.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 30 Jan 2020 21:14:33 -0800
Message-ID: <CAPcyv4iwiMS6VZLvJad-Z9Psu9LRwfhqO643EzVRsk89qy6dwA@mail.gmail.com>
Subject: Re: [PATCH 09/10] powerpc: Enable OpenCAPI Storage Class Memory
 driver on bare metal
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        David Hildenbrand <david@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Linux MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Paul Mackerras <paulus@samba.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Greg Kurz <groug@kaod.org>,
        Qian Cai <cai@lca.pw>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 8:57 PM Alastair D'Silva <alastair@au1.ibm.com> wro=
te:
>
> On Fri, 2019-11-08 at 08:10 +0100, Frederic Barrat wrote:
> >
> > Le 25/10/2019 =C3=A0 06:47, Alastair D'Silva a =C3=A9crit :
> > > From: Alastair D'Silva <alastair@d-silva.org>
> > >
> > > Enable OpenCAPI Storage Class Memory driver on bare metal
> > >
> > > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > > ---
> > >   arch/powerpc/configs/powernv_defconfig | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > >
> > > diff --git a/arch/powerpc/configs/powernv_defconfig
> > > b/arch/powerpc/configs/powernv_defconfig
> > > index 6658cceb928c..45c0eff94964 100644
> > > --- a/arch/powerpc/configs/powernv_defconfig
> > > +++ b/arch/powerpc/configs/powernv_defconfig
> > > @@ -352,3 +352,7 @@ CONFIG_KVM_BOOK3S_64=3Dm
> > >   CONFIG_KVM_BOOK3S_64_HV=3Dm
> > >   CONFIG_VHOST_NET=3Dm
> > >   CONFIG_PRINTK_TIME=3Dy
> > > +CONFIG_OCXL_SCM=3Dm
> > > +CONFIG_DEV_DAX=3Dy
> > > +CONFIG_DEV_DAX_PMEM=3Dy

This specific line is not needed since DEV_DAX_PMEM already defaults to DEV=
_DAX.

> > > +CONFIG_FS_DAX=3Dy
> >
> > If this really the intent or do we want to activate DAX only if
> > CONFIG_OCXL_SCM is enabled?
> >
> >    Fred
>
> We had a bit of a play around with reworking this the other day.
>
> Putting them in as depends didn't make sense, as they are "soft"
> dependancies - the driver works and you can do some things without DAX.
>
> Adding them as selects was rejected as selecting symbols that can also
> be manually select is discouraged.
>
> We ended up going full circle and adding them back to the defconfig.

This dovetails with a suggestion Dave made a while back [1]. Given all
the pieces that need to be turned on to have a "feature complete"
persistent memory enabled build it would be nice to have general
config symbols that go and select all the necessary dependencies for
DAX, and let the rest happen by default.

[1]: https://lore.kernel.org/lkml/20161129021052.GF28177@dastard/
