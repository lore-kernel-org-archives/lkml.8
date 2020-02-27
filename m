Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DE9C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043B92467B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="eY0hwqHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgB0MIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:08:43 -0500
Received: from mout.web.de ([212.227.17.11]:58339 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbgB0MIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:08:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582805318;
        bh=oblJ0ZqVeOm5zxzKRMAMjRIEBFIOi7aI6fy4fhmrhJY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=eY0hwqHAqw9HfZuB91Gmcj61uayaCcHegG1DmL4ISXGYnOLVe95hJBYfTgOfTywV/
         8QGvnzbsmyUOP6l/hc8cRr4OyjHmbPfIf8dtv8FMoBJiRBZLikVIvkks09tvXj7hZE
         w8iSbQtNuR/ILFLpq9E02IfvVlmhSvAlIXwSUibU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.170]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MZDKy-1iqs4w2uZ2-00Kuud; Thu, 27
 Feb 2020 13:08:38 +0100
Date:   Thu, 27 Feb 2020 13:08:37 +0100
From:   Lukas Straub <lukasstraub2@web.de>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        dm-devel <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [dm-devel] [PATCH] dm-integrity: Prevent RMW for full tag area
 writes
Message-ID: <20200227130837.2707a09e@luklap>
In-Reply-To: <alpine.LRH.2.02.2002260906280.17883@file01.intranet.prod.int.rdu2.redhat.com>
References: <20200220190445.2222af54@luklap>
        <alpine.LRH.2.02.2002251127070.1014@file01.intranet.prod.int.rdu2.redhat.com>
        <20200226092705.61b7dcf4@luklap>
        <alpine.LRH.2.02.2002260906280.17883@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ozkZigUwfVKoE3DL7WFXu+YQcXXWnYtpD9IbAGYs7IJxt1ubQTN
 SHC9UU9XqrDAu1uRTltUZAZ2GrweD8ytp/CvcIanE4dasxZzRhj5YaJjShacXLqqVEIopcd
 kevxWcFum7FLWkiyfcu6kUpwPDGb/c0fNL5RItB4br4N+3h5ahWBGeXsyBJ5Ru7NNQtCeej
 o20t4k16Nvph+5fGalPWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bGXnTMFBTCY=:wSGQorkeuJSsKeZcPAWTl7
 FnpjBU4+E8NXkRkj/o2rTtP06NQLCUitnDufM1UlYo1opugvHw4IWB+hnr64qQnohggxS8kKH
 ze7n6SMJ9vwCscOYs0gdPmic9ebvokGEFQD86qr9JFygUZFe0hdKlMrpVf+BY/pLToDKRQgIW
 kRnjbSVKOd1wyatz6p2V0m4HQ0Q5rH+PbXents6WF+F+O0us4qPdWvhPBVV0yvJrTt/2qK/Ye
 NBxuG7uO5hRVAdfa/c4l2YwUBkWGlk8EY1FZE23/NR5qfYnsCFE3VIIJgYAqpT/gPVn+3bCfI
 kx3sm1dSqrE85oT9TGgSWrs0Kt7KsOk9IQgfh5e0inlk5FWIhmpklriDvgLPw646ouxW8Iej7
 n9UYvXd5WEY+oma/Qd/IhW2USrkvgqNlgxLicTlcuxeMsSRDTLNoYlzrqmPwbwr8bZZ0TGusn
 WmrVmCzHtfqhZUeLz0eSXIoNrP5nZ03Q8/PcE9jfUy2UjGtUv2RgSjjN9jzASugpsDfrsLXNw
 PgP992fV2lL2u8eo99/RNyMgI/mvQPaFBhY7T2boaYDpr/9SG8AHYQ19mLiFHjoiWJtiWyeRy
 sj36aV5nvLMU1JqjOD5QU+BRzNtzQd3wBsxns9wYIeL4LDU6Xt0kGaNizYCERCzEPX6pkOAAb
 3hN+doYywnax4YSyc5TWBGcn9UfScjvsYMpICQ8zA0n0hoG0it4vbE7DbhI2fX9dSdjuF3SxG
 xXgKnaA4hjCs4SoG5Z/L809+FMDDSfo895qBOOVLdneWGfNmirlN1sXYWdShp4cy6qelSYQ4b
 4+c7D8ypSZ5iB4UcCNQH3lsBcxhbzEXFysUWyvDfqFqe+jPK6KF62N4SSo79Kg+CY/h40hhgm
 DROpepuBnsa+s2dQQ+EIj0LHpxg07VZlkmuguZfGP+X+DnkKYRxja45P7K7LA4Ch+GXfRrUtM
 04+7WOfUJiwcWFSYyvFPGFPcpX4S+al+5xAIAWcWPDKVIypYD7wh//7rLELPViFMaOLxAMzGU
 Wv9pdxESQAwOIKizRE+LWBkOAoTsHPnKbgtEcHjQlwTBG7PIW+yLKsser22Do2ZVE41OOtHyZ
 PVPyDNUGpElcTJ7wcipco8sMuOfUZ9Q51Ro3+mPFKBuuvPrncqy5L/H7YFUwjC5Nqy5EkqCxm
 b6c39aeUJr9o1yqBvcOq3uX85qKIcoCFLyE+xUq9Qo9IrzpC5e5ExF1gOpaDGI6q7LzdTTvu/
 wMeDurKN2svYmmxyP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020 09:14:31 -0500 (EST)
Mikulas Patocka <mpatocka@redhat.com> wrote:

> On Wed, 26 Feb 2020, Lukas Straub wrote:
>
> > > > -		data =3D dm_bufio_read(ic->bufio, *metadata_block, &b);
> > > > -		if (IS_ERR(data))
> > > > -			return PTR_ERR(data);
> > > > +		/* Don't read tag area from disk if we're going to overwrite it=
 completely */
> > > > +		if (op =3D=3D TAG_WRITE && *metadata_offset =3D=3D 0 && total_s=
ize >=3D ic->metadata_run) {
> > >
> > > Hi
> > >
> > > This is incorrect logic because ic->metadata_run is in the units of
> > > 512-byte sectors and total_size is in bytes.
> > >
> > > If I correct the bug and change it to "if (op =3D=3D TAG_WRITE &&
> > > *metadata_offset =3D=3D 0 && total_size >=3D ic->metadata_run << SEC=
TOR_SHIFT)",
> > > then the benchmark doesn't show any performance advantage at all.
> >
> > Uh oh, looking at it again i have mixed up sectors/bytes elsewhere too=
.
> > Actually, could we rewrite this check like
> >  total_size >=3D (1U << SECTOR_SHIFT << ic->log2_buffer_sectors)?
> > this should work, right?
> > So we only have to overwrite part of the tag area, as long as it's who=
le sectors.
> >
> > > You would need much bigger bios to take advantage for this - for exa=
mple,
> > > if we have 4k block size and 64k metadata buffer size and 4-byte crc=
32,
> > > there are 65536/4=3D16384 tags in one metadata buffer and we would n=
eed
> > > 16384*4096=3D64MiB bio to completely overwrite the metadata buffer. =
Such big
> > > bios are not realistic.
> >
> > What prevents us from using a single sector as the tag area? (Which wa=
s
>
> Single sector writes perform badly on SSDs (and on disks with 4k physica=
l
> sector size). We would need at least 4k.
People with SSDs can still use a large tag area.

> There's another problem - using smaller metadata blocks will degrade rea=
d
> performance, because we would need to issue more requests to read the
> metadata.
We can use prefetching, dm-bufio supports that.

> > my assumption with this patch) Then we would have (with 512b sectors)
> > 512/4 =3D 128 tags =3D 64k bio, which is still below the optimal write=
 size
>
> 4096/4*4096 =3D 4MiB - it may be possible, but it's still large.

We don't have to fill whole sector with metadata, we can for example use j=
ust the first
512 bytes (giving 512/4*4096 =3D 512k writes).
The space overhead is negligible:
For 1T of data we have 1G of metadata if we fill the whole sector.
If we use just the first 512 bytes, we get 8G of metadata.

Regards,
Lukas Straub

> > of raid5/6. I just tried to accomplish this, but there seems to be
> > minimum limit of interleave_sectors.
> >
> > Regards,
> > Lukas Straub
>
> Mikulas
>

