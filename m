Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC9EC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C813F20789
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585060070;
	bh=t+Sb33ZjPcisbGKgkhqBELHezEdoT5YtLW05AptApis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=g9Z7utcbT5Glf8+UjMzAUGlDKc90a8A73Kim8VcfPqx+Zvh+SBpcxjSwQwlJV6ctJ
	 2zEZmQ6I8LjcdlCCxbgq3YCMgwoSTfXO+Oa7uYcL+gkv7q26g177dvqzF2rQ37Gr0A
	 hwNYBTqzT26U1rbJTwF+Lza787B9q/EMQh0Inrr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgCXO1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbgCXO1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:27:49 -0400
Received: from coco.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8D3520788;
        Tue, 24 Mar 2020 14:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585060068;
        bh=t+Sb33ZjPcisbGKgkhqBELHezEdoT5YtLW05AptApis=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xlWFO1kxav6222NoaAcI+ZLD07pDFnnXwyyfz1xW8ugDomdoIKwPN+MWyy1fB6sCA
         3Z4feHEJl9jgr0PwJb41t2UpjofJjFbdsIrUPThPR83LXlU5GuuamO2TJO8/oIpTti
         wE/4GduNQYPb9xMgxE2FZk/NOThBGNcYN9FJCw8I=
Date:   Tue, 24 Mar 2020 15:27:42 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net,
        Helen Koike <helen.koike@collabora.com>
Subject: Re: [PATCH v2 00/20] Reorganize media Kconfig
Message-ID: <20200324152742.1e21d644@coco.lan>
In-Reply-To: <0e4b107c-eb85-9726-3e77-5999b9b6a0ef@xs4all.nl>
References: <cover.1585057134.git.mchehab+huawei@kernel.org>
        <0e4b107c-eb85-9726-3e77-5999b9b6a0ef@xs4all.nl>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 24 Mar 2020 14:58:59 +0100
Hans Verkuil <hverkuil-cisco@xs4all.nl> escreveu:

> On 3/24/20 2:42 PM, Mauro Carvalho Chehab wrote:
> > This patch series do lots of reorg at the media Kconfig options.
> > It also move test drivers from platform dir to a new one.  
> 
> You sent this to linux-doc, but you probably meant linux-media.
> 
> Can you repost?

Oh! Sorry for that. I used the same git clone I have lots of doc patches,
as it would make easier for me to rebase, but forgot that the send
code inside .git/config was pointing to a different c/c list.

Resent.

> 
> Regards,
> 
> 	Hans
> 
> > 
> > After this change, the main config is organized on menus, allowing to
> > select:
> > 
> > 	- type of devices selection - the filtering options
> > 	- Media core options - with API and other core stuff
> > 	- Media core extra options
> > 	- Media drivers
> > 	- Media ancillary drivers
> > 
> > The "type of devices" menu has the filtering options for:
> > 
> > 	- Cameras and video grabbers
> > 	- Analog TV
> > 	- Digital TV
> > 	- AM/FM radio receivers/transmitters
> > 	- SDR
> > 	- CEC
> > 	- Embeded devices (SoC)
> > 	- Test drivers
> > 
> > This way, one interested only on embedded devices can unselect
> > everything but "Embedded devices (SoC)" option.
> > 
> > Distros for PC/Laptops can enable everything but 
> > "Embedded devices (SoC)" and "Test drivers".
> > 
> > Users can select just what they want, without bothering with
> > hundreds of options that he won't have any clue about their
> > meanings.
> > 
> > Mauro Carvalho Chehab (20):
> >   media: dvb-usb: auto-select CYPRESS_FIRMWARE
> >   media: Kconfig: not all V4L2 platform drivers are for camera
> >   media: pci: move VIDEO_PCI_SKELETON to a different Kconfig
> >   media: reorganize the drivers menu options
> >   media: Kconfig: update the MEDIA_SUPPORT help message
> >   media: Kconfig: use a sub-menu to select supported devices
> >   media: Kconfig: add an option to filter in/out the embedded drivers
> >   media: split test drivers from platform directory
> >   media: Kconfig: make filtering devices optional
> >   media: Kconfig: move CEC-specific options to cec/Kconfig
> >   media: Kconfig: move comment to siano include
> >   media: Kconfig: move DVB-specific options to dvb-core/Kconfig
> >   media: Kconfig: move V4L2 subdev API to v4l2-core/Kconfig
> >   media: Kconfig: move drivers-specific TTPCI_EEPROM Kconfig var
> >   media: Kconfig: move media controller core select to main Kconfig
> >   media: Kconfig: better organize menu items
> >   media: Kconfig: mode firewire comment to firewire/Kconfig
> >   media: Kconfig: place all options under a sub-menu
> >   media: Kconfig: move the position of sub-driver autoselection
> >   media: Kconfig: on !EMBEDDED && !EXPERT, enable driver filtering
> > 
> >  drivers/media/Kconfig                         | 216 ++++++++++--------
> >  drivers/media/cec/Kconfig                     |  10 +
> >  drivers/media/common/Kconfig                  |   2 +-
> >  drivers/media/dvb-core/Kconfig                |  26 +++
> >  drivers/media/firewire/Kconfig                |   5 +-
> >  drivers/media/mc/Kconfig                      |   9 -
> >  drivers/media/mmc/Kconfig                     |   1 -
> >  drivers/media/mmc/siano/Kconfig               |   2 +
> >  drivers/media/pci/Kconfig                     |  10 +
> >  drivers/media/platform/Kconfig                |  24 --
> >  drivers/media/platform/Makefile               |   5 -
> >  drivers/media/test_drivers/Kconfig            |  28 +++
> >  drivers/media/test_drivers/Makefile           |   9 +
> >  .../vicodec/Kconfig                           |   0
> >  .../vicodec/Makefile                          |   0
> >  .../vicodec/codec-fwht.c                      |   0
> >  .../vicodec/codec-fwht.h                      |   0
> >  .../vicodec/codec-v4l2-fwht.c                 |   0
> >  .../vicodec/codec-v4l2-fwht.h                 |   0
> >  .../vicodec/vicodec-core.c                    |   0
> >  .../media/{platform => test_drivers}/vim2m.c  |   0
> >  .../{platform => test_drivers}/vimc/Kconfig   |   0
> >  .../{platform => test_drivers}/vimc/Makefile  |   0
> >  .../vimc/vimc-capture.c                       |   0
> >  .../vimc/vimc-common.c                        |   0
> >  .../vimc/vimc-common.h                        |   0
> >  .../vimc/vimc-core.c                          |   0
> >  .../vimc/vimc-debayer.c                       |   0
> >  .../vimc/vimc-scaler.c                        |   0
> >  .../vimc/vimc-sensor.c                        |   0
> >  .../vimc/vimc-streamer.c                      |   0
> >  .../vimc/vimc-streamer.h                      |   0
> >  .../{platform => test_drivers}/vivid/Kconfig  |   0
> >  .../{platform => test_drivers}/vivid/Makefile |   0
> >  .../vivid/vivid-cec.c                         |   0
> >  .../vivid/vivid-cec.h                         |   0
> >  .../vivid/vivid-core.c                        |   0
> >  .../vivid/vivid-core.h                        |   0
> >  .../vivid/vivid-ctrls.c                       |   0
> >  .../vivid/vivid-ctrls.h                       |   0
> >  .../vivid/vivid-kthread-cap.c                 |   0
> >  .../vivid/vivid-kthread-cap.h                 |   0
> >  .../vivid/vivid-kthread-out.c                 |   0
> >  .../vivid/vivid-kthread-out.h                 |   0
> >  .../vivid/vivid-kthread-touch.c               |   0
> >  .../vivid/vivid-kthread-touch.h               |   0
> >  .../vivid/vivid-meta-cap.c                    |   0
> >  .../vivid/vivid-meta-cap.h                    |   0
> >  .../vivid/vivid-meta-out.c                    |   0
> >  .../vivid/vivid-meta-out.h                    |   0
> >  .../vivid/vivid-osd.c                         |   0
> >  .../vivid/vivid-osd.h                         |   0
> >  .../vivid/vivid-radio-common.c                |   0
> >  .../vivid/vivid-radio-common.h                |   0
> >  .../vivid/vivid-radio-rx.c                    |   0
> >  .../vivid/vivid-radio-rx.h                    |   0
> >  .../vivid/vivid-radio-tx.c                    |   0
> >  .../vivid/vivid-radio-tx.h                    |   0
> >  .../vivid/vivid-rds-gen.c                     |   0
> >  .../vivid/vivid-rds-gen.h                     |   0
> >  .../vivid/vivid-sdr-cap.c                     |   0
> >  .../vivid/vivid-sdr-cap.h                     |   0
> >  .../vivid/vivid-touch-cap.c                   |   0
> >  .../vivid/vivid-touch-cap.h                   |   0
> >  .../vivid/vivid-vbi-cap.c                     |   0
> >  .../vivid/vivid-vbi-cap.h                     |   0
> >  .../vivid/vivid-vbi-gen.c                     |   0
> >  .../vivid/vivid-vbi-gen.h                     |   0
> >  .../vivid/vivid-vbi-out.c                     |   0
> >  .../vivid/vivid-vbi-out.h                     |   0
> >  .../vivid/vivid-vid-cap.c                     |   0
> >  .../vivid/vivid-vid-cap.h                     |   0
> >  .../vivid/vivid-vid-common.c                  |   0
> >  .../vivid/vivid-vid-common.h                  |   0
> >  .../vivid/vivid-vid-out.c                     |   0
> >  .../vivid/vivid-vid-out.h                     |   0
> >  drivers/media/usb/Kconfig                     |   6 +
> >  drivers/media/usb/dvb-usb/Kconfig             |   1 +
> >  drivers/media/v4l2-core/Kconfig               |  19 +-
> >  79 files changed, 222 insertions(+), 151 deletions(-)
> >  create mode 100644 drivers/media/test_drivers/Kconfig
> >  create mode 100644 drivers/media/test_drivers/Makefile
> >  rename drivers/media/{platform => test_drivers}/vicodec/Kconfig (100%)
> >  rename drivers/media/{platform => test_drivers}/vicodec/Makefile (100%)
> >  rename drivers/media/{platform => test_drivers}/vicodec/codec-fwht.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vicodec/codec-fwht.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vicodec/codec-v4l2-fwht.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vicodec/codec-v4l2-fwht.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vicodec/vicodec-core.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vim2m.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vimc/Kconfig (100%)
> >  rename drivers/media/{platform => test_drivers}/vimc/Makefile (100%)
> >  rename drivers/media/{platform => test_drivers}/vimc/vimc-capture.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vimc/vimc-common.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vimc/vimc-common.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vimc/vimc-core.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vimc/vimc-debayer.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vimc/vimc-scaler.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vimc/vimc-sensor.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vimc/vimc-streamer.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vimc/vimc-streamer.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/Kconfig (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/Makefile (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-cec.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-cec.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-core.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-core.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-ctrls.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-ctrls.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-kthread-cap.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-kthread-cap.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-kthread-out.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-kthread-out.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-kthread-touch.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-kthread-touch.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-meta-cap.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-meta-cap.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-meta-out.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-meta-out.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-osd.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-osd.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-radio-common.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-radio-common.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-radio-rx.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-radio-rx.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-radio-tx.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-radio-tx.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-rds-gen.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-rds-gen.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-sdr-cap.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-sdr-cap.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-touch-cap.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-touch-cap.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-vbi-cap.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-vbi-cap.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-vbi-gen.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-vbi-gen.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-vbi-out.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-vbi-out.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-vid-cap.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-vid-cap.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-vid-common.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-vid-common.h (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-vid-out.c (100%)
> >  rename drivers/media/{platform => test_drivers}/vivid/vivid-vid-out.h (100%)
> >   
> 



Thanks,
Mauro
