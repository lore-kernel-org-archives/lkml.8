Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE637C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9B320788
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584965518;
	bh=NOYAHGc7SfuBpH+I/0vIeX8pbUuuw+eRI9MrS0fRC0E=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=CpXDp6EiQV2ocDWhnFHo7y3ppyupXSD3d9IMXLRvq1YvexTEZXvLWM0iBod9bcBtK
	 Q+ECQZcJflXc0zJjESJV2zdgXcIafYk96lY0xC0prOifdHuuWh3++gD80JG5ky1Uty
	 IX1z35uS9KETWl/wjQvqz9XBPber1p2ctWFtPfDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgCWML5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:11:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbgCWML5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:11:57 -0400
Received: from localhost (unknown [122.178.205.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21C0D20784;
        Mon, 23 Mar 2020 12:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584965516;
        bh=NOYAHGc7SfuBpH+I/0vIeX8pbUuuw+eRI9MrS0fRC0E=;
        h=Date:From:To:Cc:Subject:From;
        b=FT9ToI1tFBkNtImzudBIzaRnWIjZ4j5LC6g9TsemtsaA6pEZ0xtStJMbwgNqtTeX1
         I6HEJBZ43Rf3JKn/qR6c6k/D7R2+mVwvUVKGLcawQIeHp8BjmJrL1eKMpEiN76fkvD
         BfGKiLcDDyXnaNWYrBT3Mand5IeZh4FKbcqdx72E=
Date:   Mon, 23 Mar 2020 17:41:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire updates for v5.7-rc1
Message-ID: <20200323121151.GI72691@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Here are the changes for this cycle. Bunch of stream related and pm
related changes to core and Intel drivers. Few changes to QC driver too
Please pull.

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.7-rc1

for you to fetch changes up to 39ec6f992131f0e88910700286d83f5f48f4ee8f:

  soundwire: qcom: add support for get_sdw_stream() (2020-03-20 19:35:40 +0=
530)

----------------------------------------------------------------
soundwire updates for v5.7-rc1

This contains updates to stream and pm handling in the core as well as
updates to Intel drivers for hw sequencing and multi-link.

Details:
Core:
  - Updates to stream handling for state machine checks
  - Changes to handle potential races for probe/enumeration and init of the=
 bus
  - Add no pm version of read and writes
  - Support for multiple Slave on same link
  - Add read_only_wordlength for simple/reduced ports

Intel:
  - Updates to cadence lib to handle hw sequencing
  - Support for audio dai calls in intel driver
  - Multi link support for cadence lib

Qualcomm:
  - Support for get_sdw_stream()

----------------------------------------------------------------
Bard Liao (2):
      soundwire: stream: only prepare stream when it is configured.
      soundwire: bus: provide correct return value on error

Pierre-Louis Bossart (26):
      soundwire: stream: update state machine and add state checks
      soundwire: stream: do not update parameters during DISABLED-PREPARED =
transition
      soundwire: intel: rename res field as link_res
      soundwire: intel: free all resources on hw_free()
      soundwire: bus: fix race condition with probe_complete signaling
      soundwire: bus: fix race condition with enumeration_complete signaling
      soundwire: bus: fix race condition with initialization_complete signa=
ling
      soundwire: bus: add PM/no-PM versions of read/write functions
      soundwire: bus: write Slave Device Number without runtime_pm
      soundwire: bus: add helper to clear Slave status to UNATTACHED
      soundwire: bus: disable pm_runtime in sdw_slave_delete
      soundwire: bus: don't treat CMD_IGNORED as error on ClockStop
      soundwire: cadence: remove useless prototypes
      soundwire: add helper macros for devID fields
      soundwire: cadence: s/update_config/config_update
      soundwire: cadence: handle error cases with CONFIG_UPDATE
      soundwire: cadence: mask Slave interrupt before stopping clock
      soundwire: cadence: merge routines to clear/set bits
      soundwire: cadence: move clock/SSP related inits to dedicated function
      soundwire: cadence: make SSP interval programmable
      soundwire: cadence: reorder MCP_CONFIG settings
      soundwire: cadence: enable NORMAL operation in cdns_init()
      soundwire: cadence: remove PREQ_DELAY assignment
      soundwire: cadence: remove automatic command retries
      soundwire: cadence: commit changes in the exit_reset() sequence
      soundwire: cadence: multi-link support

Rander Wang (11):
      soundwire: stream: fix support for multiple Slaves on the same link
      soundwire: stream: don't program ports when a stream that has not bee=
n prepared
      soundwire: intel: add prepare support in sdw dai driver
      soundwire: intel: add trigger support in sdw dai driver
      soundwire: intel: add sdw_stream_setup helper for .startup callback
      soundwire: bus: fix io error when processing alert event
      soundwire: bus: add clock stop helpers
      soundwire: cadence: simplifiy cdns_init()
      soundwire: cadence: add interface to check clock status
      soundwire: cadence: add clock_stop/restart routines
      soundwire: cadence: fix a io timeout issue in S3 test

Srinivas Kandagatla (3):
      soundwire: stream: use sdw_write instead of update
      soundwire: stream: Add read_only_wordlength flag to port properties
      soundwire: qcom: add support for get_sdw_stream()

Vinod Koul (2):
      Merge branch 'topic/asoc' into next
      Merge branch 'topic/ro_wordlength' into next

randerwang (1):
      soundwire: cadence: clear FIFO to avoid pop noise issue on playback s=
tart

 Documentation/driver-api/soundwire/stream.rst |  61 ++-
 drivers/soundwire/bus.c                       | 537 ++++++++++++++++++++++=
+---
 drivers/soundwire/bus.h                       |   9 +
 drivers/soundwire/bus_type.c                  |   5 +
 drivers/soundwire/cadence_master.c            | 282 ++++++++++++--
 drivers/soundwire/cadence_master.h            |  17 +-
 drivers/soundwire/intel.c                     | 200 +++++++++-
 drivers/soundwire/qcom.c                      |   8 +
 drivers/soundwire/slave.c                     |   4 +
 drivers/soundwire/stream.c                    | 115 ++++--
 include/linux/soundwire/sdw.h                 |  49 +++
 11 files changed, 1130 insertions(+), 157 deletions(-)

Thanks
--=20
~Vinod

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl54p4cACgkQfBQHDyUj
g0dSWhAAswh1ssqO2IFtOiUrRQQrz80TZn08bjD76pbiW+3T1FhFAsgGsd2ZEMQB
PquQZ5CbClvm3ETFsJpv3ZJCxz3r9nBFToty171wJhZCP4sa4RJC7BruZyDR7G/R
QdqevpcmqLCSxcF3jpd1YmyufI3X5ptK8NFuvVGQJlBk2dTBnnWqUTNUrpYB/AlK
gZLKoleb8OId0Wc9GW4qcveGuLnt2JSu+7cyoRtDW96zHpft8Dy+RqEHPe7HDa2m
a3WvGGgvSZqwMVY9L7kb4BwbU/pPo7kO+qCu1NDboMI0jkLh8RiV78CF40GAIhKD
WXk6lJpG8H2A1sxctB5eV61tQaBVIHMIKSIIfW8D8GXOPwgO6W8RR06CJ8Z680ix
Jt8P6TrCvH7EvFbLhg+e1buaHh2PqOQigcbQS8pIftEbsEBMWAumzmOMN8rDqYqf
MOWdVSNWNVTu/1Vsoaspf6hqOwv1WhsA8eGwPLPeAmtkFNSfk1+1ed+FlUGHzCXx
VQaBz7/Zb1dhXAlqpDVUnyFmQd9SZqJhpzW/6V6wy6LBbycE77DxcIuxf4m5hb8A
167JHayLNxJca1gCjPcsfJyFTZTjqsFwi1lWMU11daReetbkKnRGHX7kyKwJykLR
nbVtag7e7+LVeM/RoGcvdaIeUJQT+3402JFqxlGfJw5zIWPdn3E=
=qAjD
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
