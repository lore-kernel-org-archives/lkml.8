Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75FBC433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A052084C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mixtli.metztli.it header.i=@mixtli.metztli.it header.b="UIGPMEkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgH0VyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 17:54:12 -0400
Received: from mail7.static.mailgun.info ([104.130.122.7]:45252 "EHLO
        mail7.static.mailgun.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0VyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 17:54:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mixtli.metztli.it; q=dns/txt;
 s=mx; t=1598565251; h=From: Date: Message-Id: To: Subject: Sender;
 bh=o+9aW35LyZ+a6CX/oxEFA/hVTeU4qS0Hd7WDhPR4GUM=; b=UIGPMEkYeXF6GjSu29GA7J9euCEhilY6CnDR9HIBhMw+Kissy+TRCiLrfLTRImAxIkz9zpQP
 Vfu478hiXzX5SRB/Mx5NFptESGFjXShdU0HSer8/k5zaZoAdZehwbyfdEQQtvmcJfkjnwG/S
 72wh16HotXPUKDDgCpYqJwN2yuY=
X-Mailgun-Sending-Ip: 104.130.122.7
X-Mailgun-Sid: WyIxYzIzYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgIjE3YjU0Il0=
Received: from huitzilopochtli.metztli-it.com
 (99-130-254-3.lightspeed.sntcca.sbcglobal.net [99.130.254.3]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f482b702fd6d21f0a2ffa79 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 27 Aug 2020 21:53:52 GMT
Received: by huitzilopochtli.metztli-it.com (Postfix, from userid 1000)
        id 620A468F3402; Thu, 27 Aug 2020 14:53:51 -0700 (PDT)
Subject: Re: [ANNOUNCE] Reiser5: Selective File Migration - User Interface
To:     <edward.shishkin@gmail.com>, <reiserfs-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: mail (GNU Mailutils 3.9)
Message-Id: <20200827215351.620A468F3402@huitzilopochtli.metztli-it.com>
Date:   Thu, 27 Aug 2020 14:53:51 -0700 (PDT)
From:   Metztli Information Technology <jose.r.r@metztli.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 2:13 PM Edward Shishkin <edward.shishkin@gmail.com> wrote:
>
> [...]
>
> >
> > FYI Although not officially, the Debian metaframework Buster AMD64 distribution might be the first to support native installation of Reiser4 SFRN 5.1.3, kernel and reiser4progs 2.0.3, file system utilities.
> >
> > I have already made a couple of successful Metztli Reiser4 SFRN 5 native installations onto ~100 GB slices, which root file system is formatted in 'Reiser5' and 1 GB /boot in JFS.
> > https://metztli.it/reiser5 (Screenshot 600x338 size)
> >
> > The upgraded netboot installation media metztli-reiser4-sfrn5.iso is available at:
> > https://sourceforge.net/projects/debian-reiser4/
> > as well as
> > https://metztli.it/buster-reiser5/metztli-reiser4-sfrn5.iso
> > https://metztli.it/buster-reiser5/metztli-reiser4-sfrn5.iso.SHA256SUM
> >
> > Likely the brick/volume feature(s) will be useful in Cloud fabric infrastructures, like Google's, where reiser4 excels.
> >
> > The current SFRN 5.1.3 -patched Zstd -compressed kernel in the installation media is Debian's 5.7.10.
>
>
> wow, reiser5 from the box? I might want to try..
Well, it is more of a 'reference implementation' as there are persons who reached out to me because their builds succeeded, they were able to format in reiser4 SFRN x.y.z, but they were not able to mount their partition(s).
Turns out, they were inadvertently mixing SFRN 4.0.2 with 5.1.3, either in the reiser4 kernel patch -- released with the same in both instances -- or in the reiser4progs.

>
> >
> > The installer defaults to create the root system reiser5 -formatted partition as:
> > mkfs.reiser4 -yo "create=reg42"
>
>
> "reg42" is default profile in reiser4progs-2.0.3 (check by
> "mkfs.reiser4 -p") - there is no need to specify it via option.
Acknowledged. Thanks.

>
> Have you had a chance to play with logical volumes (add/remove
> bricks, etc)?
That is coming up. I still have to create/customize an image of Metztli Reiser4 SFRN5 for a Google Compute Engine (GCE) minimal ~200GB instance for evaluation.
Fact is 'not all clouds are created equal' -- even if KVM -based. For instance, reiser4 SFRN 4.0.2 on a trial Linode small ~80GB SSD slice(s) with 2 virtual cpus frequently hung under short sustained disk/network I/O usage.
I have not experienced that with reiser4 SFRN 4.0.2 on GCE -- where sometimes I allocate eight to sixteen virtual cpus with 16, 32, or even 64, GBs of RAM, on a region hosting AMD Epyc, for fast kernel building ops.

But testing a relatively small bootable image first will usually provide insight if adding one, two... eight, TB slices will make sense later on.
>
> Thanks!
> Edward.

Best Professional Regards.

-- 
Jose R R
http://metztli.it
---------------------------------------------------------------------------------------------
Download Metztli Reiser4: Debian Buster w/ Linux 5.7.10 AMD64
---------------------------------------------------------------------------------------------
feats ZSTD compression https://sf.net/projects/metztli-reiser4/
-------------------------------------------------------------------------------------------
Official current Reiser4 resources: https://reiser4.wiki.kernel.org/
