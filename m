Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34AEC35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 15:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A402067C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 15:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Srnz0n2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgBBPui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 10:50:38 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:59070 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgBBPui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 10:50:38 -0500
Date:   Sun, 02 Feb 2020 15:50:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1580658635;
        bh=Sf33ELn3vL0wbKIMUe34Sc9qlpaLyZtY2LGk/koDQ2I=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=Srnz0n2ppQt2y8jNw/RqeDcr6vAtvK3ikRfLngKz51/nwszHCbi55Hn8gUbG6+MnR
         NMpec3uAssELazJSR2RxFBqoIj0tDvkxvypS2TCXchHrMUWy9R3issj8IzRK+ROhXm
         6p+gAPUVcuTm0S41duejvhY73cbXTmgn9cGsn4/8=
To:     linux-media@vger.kernel.org
From:   =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     Helen Koike <helen.koike@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Reply-To: =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: [PATCH 0/3] media: vimc: Add support for GBR and BGR formats on source pad of debayer
Message-ID: <20200202155019.1029993-1-nfraprado@protonmail.com>
Feedback-ID: cwTKJQq-dqva77NrgNeIaWzOvcDQqfI9VSy7DoyJdvgY6-nEE7fD-E-3GiKFHexW4OBWbzutmMZN6q4SflMDRw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The objective of this series is to add support for GBR and BGR media bus fo=
rmats
for the source pad of debayer subdevices of the vimc driver.

Since the GBR media bus code doesn't have a corresponding pixelformat, it n=
eeded
to use the pixelformat of another bus code.

The first patch makes it possible to have multiple media bus codes mapping =
to
the same pixelformat.

The second patch adds the GBR media bus code, using the RGB pixelformat.

The third patch adds support for GBR and BGR media bus formats on the sourc=
e
pad of the debayer subdevice.

This patch series passed all tests of v4l2-compliance:
$ compliance_git -m /dev/media0
v4l2-compliance SHA: c4a62f26c5c3ecd856ca10cf2f0d35d100283d7f, 64 bits, 64-=
bit time_t

Grand Total for vimc device /dev/media0: 461, Succeeded: 461, Failed: 0, Wa=
rnings: 0

N=C3=ADcolas F. R. A. Prado (3):
  media: vimc: Support multiple buscodes for each pixelformat
  media: vimc: Add GBR media bus code
  media: vimc: deb: Add support for GBR and BGR bus formats on source
    pad

 drivers/media/platform/vimc/vimc-common.c  | 68 +++++++++++++---------
 drivers/media/platform/vimc/vimc-common.h  |  9 ++-
 drivers/media/platform/vimc/vimc-debayer.c | 53 +++++++++++++----
 drivers/media/platform/vimc/vimc-scaler.c  | 10 +++-
 drivers/media/platform/vimc/vimc-sensor.c  |  6 +-
 5 files changed, 102 insertions(+), 44 deletions(-)

--=20
2.25.0


