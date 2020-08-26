Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F513C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2802071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598426357;
	bh=g86A2cVRVqO5hVumv7kABxBCet3CtcOIzZjgZAVWmIw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QsiE7p4FNUNLeUNfAdwnZUt6rvIvBBIXmDNymIMAt60JQnrKtJ6vgMK4BXGQ1Rssy
	 0ibukvcIKWKF6iBkOTIAhD7PDMnJl6Y5866gHQMK2dHKSeLaGuKikUJtXJu00L9ct5
	 VQxdOi4F93YNz+XlWRcVW6v17gH2J4IZAmNsJsY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgHZHTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:19:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgHZHTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 03:19:02 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5308207DF;
        Wed, 26 Aug 2020 07:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598426329;
        bh=g86A2cVRVqO5hVumv7kABxBCet3CtcOIzZjgZAVWmIw=;
        h=From:To:Cc:Subject:Date:From;
        b=eAvul/BdHZxELN9rxy6Kmt5POU3QYafHi5U5Cr/I2BHti5DIiu2gn+0DjqC0FdPXV
         xC1gtRa/y9sOOrITR+Yp1orNZJp0YvZ8KeTCoRuEUU8YzBaMdt1WLaEYsO2rc8qBvd
         M+tKXkRvCAe5x7PrBBSN5vKY7DQJcelCHC9tTaCY=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kAphl-001Rad-KC; Wed, 26 Aug 2020 09:18:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     linux-media@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/4] media: docs: use the new SPDX header for GFDL-1.1 on *.rst files
Date:   Wed, 26 Aug 2020 09:18:36 +0200
Message-Id: <929df929283e38b388f601c2ba521257e38cc566.1598426302.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPDX v3.10 gained support for GFDL-1.1 with no invariant sections:

	https://spdx.org/licenses/GFDL-1.1-no-invariants-or-later.html

So, remove the license text, replacing them by this new SPDX
license.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/userspace-api/media/cec/cec-api.rst     | 10 +---------
 .../userspace-api/media/cec/cec-func-close.rst        |  9 +--------
 .../userspace-api/media/cec/cec-func-ioctl.rst        |  9 +--------
 .../userspace-api/media/cec/cec-func-open.rst         |  9 +--------
 .../userspace-api/media/cec/cec-func-poll.rst         |  9 +--------
 Documentation/userspace-api/media/cec/cec-funcs.rst   |  9 +--------
 Documentation/userspace-api/media/cec/cec-header.rst  |  9 +--------
 Documentation/userspace-api/media/cec/cec-intro.rst   |  9 +--------
 .../userspace-api/media/cec/cec-ioc-adap-g-caps.rst   |  9 +--------
 .../media/cec/cec-ioc-adap-g-log-addrs.rst            |  9 +--------
 .../media/cec/cec-ioc-adap-g-phys-addr.rst            |  9 +--------
 .../userspace-api/media/cec/cec-ioc-dqevent.rst       |  9 +--------
 .../userspace-api/media/cec/cec-ioc-g-mode.rst        |  9 +--------
 .../userspace-api/media/cec/cec-ioc-receive.rst       |  9 +--------
 .../userspace-api/media/cec/cec-pin-error-inj.rst     |  9 +--------
 .../media/dvb/audio-bilingual-channel-select.rst      |  9 +--------
 .../userspace-api/media/dvb/audio-channel-select.rst  |  9 +--------
 .../userspace-api/media/dvb/audio-clear-buffer.rst    |  9 +--------
 .../userspace-api/media/dvb/audio-continue.rst        |  9 +--------
 .../userspace-api/media/dvb/audio-fclose.rst          |  9 +--------
 Documentation/userspace-api/media/dvb/audio-fopen.rst |  9 +--------
 .../userspace-api/media/dvb/audio-fwrite.rst          |  9 +--------
 .../media/dvb/audio-get-capabilities.rst              |  9 +--------
 .../userspace-api/media/dvb/audio-get-status.rst      |  9 +--------
 Documentation/userspace-api/media/dvb/audio-pause.rst |  9 +--------
 Documentation/userspace-api/media/dvb/audio-play.rst  |  9 +--------
 .../userspace-api/media/dvb/audio-select-source.rst   |  9 +--------
 .../userspace-api/media/dvb/audio-set-av-sync.rst     |  9 +--------
 .../userspace-api/media/dvb/audio-set-bypass-mode.rst |  9 +--------
 .../userspace-api/media/dvb/audio-set-id.rst          |  9 +--------
 .../userspace-api/media/dvb/audio-set-mixer.rst       |  9 +--------
 .../userspace-api/media/dvb/audio-set-mute.rst        |  9 +--------
 .../userspace-api/media/dvb/audio-set-streamtype.rst  |  9 +--------
 Documentation/userspace-api/media/dvb/audio-stop.rst  |  9 +--------
 Documentation/userspace-api/media/dvb/audio.rst       |  9 +--------
 .../userspace-api/media/dvb/audio_data_types.rst      |  9 +--------
 .../userspace-api/media/dvb/audio_function_calls.rst  |  9 +--------
 Documentation/userspace-api/media/dvb/ca-fclose.rst   |  9 +--------
 Documentation/userspace-api/media/dvb/ca-fopen.rst    |  9 +--------
 Documentation/userspace-api/media/dvb/ca-get-cap.rst  |  9 +--------
 .../userspace-api/media/dvb/ca-get-descr-info.rst     |  9 +--------
 Documentation/userspace-api/media/dvb/ca-get-msg.rst  |  9 +--------
 .../userspace-api/media/dvb/ca-get-slot-info.rst      |  9 +--------
 Documentation/userspace-api/media/dvb/ca-reset.rst    |  9 +--------
 Documentation/userspace-api/media/dvb/ca-send-msg.rst |  9 +--------
 .../userspace-api/media/dvb/ca-set-descr.rst          |  9 +--------
 Documentation/userspace-api/media/dvb/ca.rst          |  9 +--------
 .../userspace-api/media/dvb/ca_data_types.rst         |  9 +--------
 .../userspace-api/media/dvb/ca_function_calls.rst     |  9 +--------
 Documentation/userspace-api/media/dvb/demux.rst       |  9 +--------
 Documentation/userspace-api/media/dvb/dmx-add-pid.rst |  9 +--------
 Documentation/userspace-api/media/dvb/dmx-expbuf.rst  |  9 +--------
 Documentation/userspace-api/media/dvb/dmx-fclose.rst  |  9 +--------
 Documentation/userspace-api/media/dvb/dmx-fopen.rst   |  9 +--------
 Documentation/userspace-api/media/dvb/dmx-fread.rst   |  9 +--------
 Documentation/userspace-api/media/dvb/dmx-fwrite.rst  |  9 +--------
 .../userspace-api/media/dvb/dmx-get-pes-pids.rst      |  9 +--------
 Documentation/userspace-api/media/dvb/dmx-get-stc.rst |  9 +--------
 Documentation/userspace-api/media/dvb/dmx-mmap.rst    |  9 +--------
 Documentation/userspace-api/media/dvb/dmx-munmap.rst  |  9 +--------
 Documentation/userspace-api/media/dvb/dmx-qbuf.rst    |  9 +--------
 .../userspace-api/media/dvb/dmx-querybuf.rst          |  9 +--------
 .../userspace-api/media/dvb/dmx-remove-pid.rst        |  9 +--------
 Documentation/userspace-api/media/dvb/dmx-reqbufs.rst |  9 +--------
 .../userspace-api/media/dvb/dmx-set-buffer-size.rst   |  9 +--------
 .../userspace-api/media/dvb/dmx-set-filter.rst        |  9 +--------
 .../userspace-api/media/dvb/dmx-set-pes-filter.rst    |  9 +--------
 Documentation/userspace-api/media/dvb/dmx-start.rst   |  9 +--------
 Documentation/userspace-api/media/dvb/dmx-stop.rst    |  9 +--------
 Documentation/userspace-api/media/dvb/dmx_fcalls.rst  |  9 +--------
 Documentation/userspace-api/media/dvb/dmx_types.rst   |  9 +--------
 .../userspace-api/media/dvb/dvb-fe-read-status.rst    |  9 +--------
 .../userspace-api/media/dvb/dvb-frontend-event.rst    |  9 +--------
 .../media/dvb/dvb-frontend-parameters.rst             |  9 +--------
 Documentation/userspace-api/media/dvb/dvbapi.rst      | 10 +---------
 Documentation/userspace-api/media/dvb/dvbproperty.rst |  9 +--------
 Documentation/userspace-api/media/dvb/examples.rst    |  9 +--------
 .../userspace-api/media/dvb/fe-bandwidth-t.rst        |  9 +--------
 .../media/dvb/fe-diseqc-recv-slave-reply.rst          |  9 +--------
 .../media/dvb/fe-diseqc-reset-overload.rst            |  9 +--------
 .../userspace-api/media/dvb/fe-diseqc-send-burst.rst  |  9 +--------
 .../media/dvb/fe-diseqc-send-master-cmd.rst           |  9 +--------
 .../media/dvb/fe-dishnetwork-send-legacy-cmd.rst      |  9 +--------
 .../media/dvb/fe-enable-high-lnb-voltage.rst          |  9 +--------
 .../userspace-api/media/dvb/fe-get-event.rst          |  9 +--------
 .../userspace-api/media/dvb/fe-get-frontend.rst       |  9 +--------
 Documentation/userspace-api/media/dvb/fe-get-info.rst |  9 +--------
 .../userspace-api/media/dvb/fe-get-property.rst       |  9 +--------
 Documentation/userspace-api/media/dvb/fe-read-ber.rst |  9 +--------
 .../media/dvb/fe-read-signal-strength.rst             |  9 +--------
 Documentation/userspace-api/media/dvb/fe-read-snr.rst |  9 +--------
 .../userspace-api/media/dvb/fe-read-status.rst        |  9 +--------
 .../media/dvb/fe-read-uncorrected-blocks.rst          |  9 +--------
 .../media/dvb/fe-set-frontend-tune-mode.rst           |  9 +--------
 .../userspace-api/media/dvb/fe-set-frontend.rst       |  9 +--------
 Documentation/userspace-api/media/dvb/fe-set-tone.rst |  9 +--------
 .../userspace-api/media/dvb/fe-set-voltage.rst        |  9 +--------
 Documentation/userspace-api/media/dvb/fe-type-t.rst   |  9 +--------
 .../media/dvb/fe_property_parameters.rst              |  9 +--------
 .../userspace-api/media/dvb/frontend-header.rst       |  9 +--------
 .../media/dvb/frontend-property-cable-systems.rst     |  9 +--------
 .../media/dvb/frontend-property-satellite-systems.rst |  9 +--------
 .../dvb/frontend-property-terrestrial-systems.rst     |  9 +--------
 .../media/dvb/frontend-stat-properties.rst            |  9 +--------
 Documentation/userspace-api/media/dvb/frontend.rst    |  9 +--------
 .../userspace-api/media/dvb/frontend_f_close.rst      |  9 +--------
 .../userspace-api/media/dvb/frontend_f_open.rst       |  9 +--------
 .../userspace-api/media/dvb/frontend_fcalls.rst       |  9 +--------
 .../userspace-api/media/dvb/frontend_legacy_api.rst   |  9 +--------
 .../media/dvb/frontend_legacy_dvbv3_api.rst           |  9 +--------
 Documentation/userspace-api/media/dvb/headers.rst     |  9 +--------
 Documentation/userspace-api/media/dvb/intro.rst       |  9 +--------
 .../userspace-api/media/dvb/legacy_dvb_apis.rst       |  9 +--------
 Documentation/userspace-api/media/dvb/net-add-if.rst  |  9 +--------
 Documentation/userspace-api/media/dvb/net-get-if.rst  |  9 +--------
 .../userspace-api/media/dvb/net-remove-if.rst         |  9 +--------
 Documentation/userspace-api/media/dvb/net-types.rst   |  9 +--------
 Documentation/userspace-api/media/dvb/net.rst         |  9 +--------
 .../media/dvb/query-dvb-frontend-info.rst             |  9 +--------
 .../userspace-api/media/dvb/video-clear-buffer.rst    |  9 +--------
 .../userspace-api/media/dvb/video-command.rst         |  9 +--------
 .../userspace-api/media/dvb/video-continue.rst        |  9 +--------
 .../userspace-api/media/dvb/video-fast-forward.rst    |  9 +--------
 .../userspace-api/media/dvb/video-fclose.rst          |  9 +--------
 Documentation/userspace-api/media/dvb/video-fopen.rst |  9 +--------
 .../userspace-api/media/dvb/video-freeze.rst          |  9 +--------
 .../userspace-api/media/dvb/video-fwrite.rst          |  9 +--------
 .../media/dvb/video-get-capabilities.rst              |  9 +--------
 .../userspace-api/media/dvb/video-get-event.rst       |  9 +--------
 .../userspace-api/media/dvb/video-get-frame-count.rst |  9 +--------
 .../userspace-api/media/dvb/video-get-pts.rst         |  9 +--------
 .../userspace-api/media/dvb/video-get-size.rst        |  9 +--------
 .../userspace-api/media/dvb/video-get-status.rst      |  9 +--------
 Documentation/userspace-api/media/dvb/video-play.rst  |  9 +--------
 .../userspace-api/media/dvb/video-select-source.rst   |  9 +--------
 .../userspace-api/media/dvb/video-set-blank.rst       |  9 +--------
 .../media/dvb/video-set-display-format.rst            |  9 +--------
 .../userspace-api/media/dvb/video-set-format.rst      |  9 +--------
 .../userspace-api/media/dvb/video-set-streamtype.rst  |  9 +--------
 .../userspace-api/media/dvb/video-slowmotion.rst      |  9 +--------
 .../userspace-api/media/dvb/video-stillpicture.rst    |  9 +--------
 Documentation/userspace-api/media/dvb/video-stop.rst  |  9 +--------
 .../userspace-api/media/dvb/video-try-command.rst     |  9 +--------
 Documentation/userspace-api/media/dvb/video.rst       |  9 +--------
 .../userspace-api/media/dvb/video_function_calls.rst  |  9 +--------
 Documentation/userspace-api/media/dvb/video_types.rst |  9 +--------
 Documentation/userspace-api/media/fdl-appendix.rst    |  9 +--------
 Documentation/userspace-api/media/gen-errors.rst      |  9 +--------
 .../media/mediactl/media-controller-intro.rst         |  9 +--------
 .../media/mediactl/media-controller-model.rst         |  9 +--------
 .../userspace-api/media/mediactl/media-controller.rst | 10 +---------
 .../userspace-api/media/mediactl/media-func-close.rst |  9 +--------
 .../userspace-api/media/mediactl/media-func-ioctl.rst |  9 +--------
 .../userspace-api/media/mediactl/media-func-open.rst  |  9 +--------
 .../userspace-api/media/mediactl/media-funcs.rst      |  9 +--------
 .../userspace-api/media/mediactl/media-header.rst     |  9 +--------
 .../media/mediactl/media-ioc-device-info.rst          |  9 +--------
 .../media/mediactl/media-ioc-enum-entities.rst        |  9 +--------
 .../media/mediactl/media-ioc-enum-links.rst           |  9 +--------
 .../media/mediactl/media-ioc-g-topology.rst           |  9 +--------
 .../media/mediactl/media-ioc-setup-link.rst           |  9 +--------
 .../userspace-api/media/mediactl/media-types.rst      |  9 +--------
 Documentation/userspace-api/media/rc/keytable.c.rst   |  9 +--------
 .../userspace-api/media/rc/lirc-dev-intro.rst         |  9 +--------
 Documentation/userspace-api/media/rc/lirc-dev.rst     |  9 +--------
 Documentation/userspace-api/media/rc/lirc-func.rst    |  9 +--------
 .../userspace-api/media/rc/lirc-get-features.rst      |  9 +--------
 .../userspace-api/media/rc/lirc-get-rec-mode.rst      |  9 +--------
 .../media/rc/lirc-get-rec-resolution.rst              |  9 +--------
 .../userspace-api/media/rc/lirc-get-send-mode.rst     |  9 +--------
 .../userspace-api/media/rc/lirc-get-timeout.rst       |  9 +--------
 Documentation/userspace-api/media/rc/lirc-header.rst  |  9 +--------
 Documentation/userspace-api/media/rc/lirc-read.rst    |  9 +--------
 .../media/rc/lirc-set-measure-carrier-mode.rst        |  9 +--------
 .../media/rc/lirc-set-rec-carrier-range.rst           |  9 +--------
 .../userspace-api/media/rc/lirc-set-rec-carrier.rst   |  9 +--------
 .../media/rc/lirc-set-rec-timeout-reports.rst         |  9 +--------
 .../userspace-api/media/rc/lirc-set-rec-timeout.rst   |  9 +--------
 .../userspace-api/media/rc/lirc-set-send-carrier.rst  |  9 +--------
 .../media/rc/lirc-set-send-duty-cycle.rst             |  9 +--------
 .../media/rc/lirc-set-transmitter-mask.rst            |  9 +--------
 .../media/rc/lirc-set-wideband-receiver.rst           |  9 +--------
 Documentation/userspace-api/media/rc/lirc-write.rst   |  9 +--------
 Documentation/userspace-api/media/rc/rc-intro.rst     |  9 +--------
 Documentation/userspace-api/media/rc/rc-protos.rst    |  4 +---
 .../userspace-api/media/rc/rc-sysfs-nodes.rst         |  9 +--------
 .../userspace-api/media/rc/rc-table-change.rst        |  9 +--------
 Documentation/userspace-api/media/rc/rc-tables.rst    |  9 +--------
 .../userspace-api/media/rc/remote_controllers.rst     | 10 +---------
 Documentation/userspace-api/media/v4l/app-pri.rst     |  9 +--------
 Documentation/userspace-api/media/v4l/async.rst       |  9 +--------
 Documentation/userspace-api/media/v4l/audio.rst       |  9 +--------
 Documentation/userspace-api/media/v4l/biblio.rst      |  9 +--------
 Documentation/userspace-api/media/v4l/buffer.rst      |  9 +--------
 .../userspace-api/media/v4l/capture-example.rst       |  9 +--------
 Documentation/userspace-api/media/v4l/capture.c.rst   |  9 +--------
 .../userspace-api/media/v4l/colorspaces-defs.rst      |  9 +--------
 .../userspace-api/media/v4l/colorspaces-details.rst   |  9 +--------
 Documentation/userspace-api/media/v4l/colorspaces.rst |  9 +--------
 Documentation/userspace-api/media/v4l/common-defs.rst |  9 +--------
 Documentation/userspace-api/media/v4l/common.rst      |  9 +--------
 Documentation/userspace-api/media/v4l/compat.rst      |  9 +--------
 Documentation/userspace-api/media/v4l/control.rst     |  9 +--------
 Documentation/userspace-api/media/v4l/crop.rst        |  9 +--------
 .../userspace-api/media/v4l/depth-formats.rst         |  9 +--------
 Documentation/userspace-api/media/v4l/dev-capture.rst |  9 +--------
 Documentation/userspace-api/media/v4l/dev-event.rst   |  9 +--------
 Documentation/userspace-api/media/v4l/dev-mem2mem.rst |  9 +--------
 Documentation/userspace-api/media/v4l/dev-meta.rst    |  9 +--------
 Documentation/userspace-api/media/v4l/dev-osd.rst     |  9 +--------
 Documentation/userspace-api/media/v4l/dev-output.rst  |  9 +--------
 Documentation/userspace-api/media/v4l/dev-overlay.rst |  9 +--------
 Documentation/userspace-api/media/v4l/dev-radio.rst   |  9 +--------
 Documentation/userspace-api/media/v4l/dev-raw-vbi.rst |  9 +--------
 Documentation/userspace-api/media/v4l/dev-rds.rst     |  9 +--------
 Documentation/userspace-api/media/v4l/dev-sdr.rst     |  9 +--------
 .../userspace-api/media/v4l/dev-sliced-vbi.rst        |  9 +--------
 Documentation/userspace-api/media/v4l/dev-subdev.rst  |  9 +--------
 Documentation/userspace-api/media/v4l/dev-touch.rst   |  9 +--------
 Documentation/userspace-api/media/v4l/devices.rst     |  9 +--------
 Documentation/userspace-api/media/v4l/diff-v4l.rst    |  9 +--------
 Documentation/userspace-api/media/v4l/dmabuf.rst      |  9 +--------
 Documentation/userspace-api/media/v4l/dv-timings.rst  |  9 +--------
 .../userspace-api/media/v4l/ext-ctrls-camera.rst      |  9 +--------
 .../userspace-api/media/v4l/ext-ctrls-codec.rst       |  9 +--------
 .../userspace-api/media/v4l/ext-ctrls-detect.rst      |  9 +--------
 .../userspace-api/media/v4l/ext-ctrls-dv.rst          |  9 +--------
 .../userspace-api/media/v4l/ext-ctrls-flash.rst       |  9 +--------
 .../userspace-api/media/v4l/ext-ctrls-fm-rx.rst       |  9 +--------
 .../userspace-api/media/v4l/ext-ctrls-fm-tx.rst       |  9 +--------
 .../media/v4l/ext-ctrls-image-process.rst             |  9 +--------
 .../media/v4l/ext-ctrls-image-source.rst              |  9 +--------
 .../userspace-api/media/v4l/ext-ctrls-jpeg.rst        |  9 +--------
 .../userspace-api/media/v4l/ext-ctrls-rf-tuner.rst    |  9 +--------
 .../userspace-api/media/v4l/extended-controls.rst     |  9 +--------
 Documentation/userspace-api/media/v4l/field-order.rst |  9 +--------
 Documentation/userspace-api/media/v4l/format.rst      |  9 +--------
 Documentation/userspace-api/media/v4l/func-close.rst  |  9 +--------
 Documentation/userspace-api/media/v4l/func-ioctl.rst  |  9 +--------
 Documentation/userspace-api/media/v4l/func-mmap.rst   |  9 +--------
 Documentation/userspace-api/media/v4l/func-munmap.rst |  9 +--------
 Documentation/userspace-api/media/v4l/func-open.rst   |  9 +--------
 Documentation/userspace-api/media/v4l/func-poll.rst   |  9 +--------
 Documentation/userspace-api/media/v4l/func-read.rst   |  9 +--------
 Documentation/userspace-api/media/v4l/func-select.rst |  9 +--------
 Documentation/userspace-api/media/v4l/func-write.rst  |  9 +--------
 Documentation/userspace-api/media/v4l/hist-v4l2.rst   |  9 +--------
 Documentation/userspace-api/media/v4l/hsv-formats.rst |  9 +--------
 Documentation/userspace-api/media/v4l/io.rst          |  9 +--------
 .../userspace-api/media/v4l/libv4l-introduction.rst   |  9 +--------
 Documentation/userspace-api/media/v4l/libv4l.rst      |  9 +--------
 .../userspace-api/media/v4l/meta-formats.rst          |  9 +--------
 Documentation/userspace-api/media/v4l/mmap.rst        |  9 +--------
 Documentation/userspace-api/media/v4l/open.rst        |  9 +--------
 .../userspace-api/media/v4l/pixfmt-bayer.rst          |  9 +--------
 .../userspace-api/media/v4l/pixfmt-compressed.rst     |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-grey.rst |  9 +--------
 .../userspace-api/media/v4l/pixfmt-indexed.rst        |  9 +--------
 .../userspace-api/media/v4l/pixfmt-intro.rst          |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-inzi.rst |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-m420.rst |  9 +--------
 .../userspace-api/media/v4l/pixfmt-meta-d4xx.rst      |  9 +--------
 .../userspace-api/media/v4l/pixfmt-meta-uvc.rst       |  9 +--------
 .../userspace-api/media/v4l/pixfmt-meta-vsp1-hgo.rst  |  9 +--------
 .../userspace-api/media/v4l/pixfmt-meta-vsp1-hgt.rst  |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-nv12.rst |  9 +--------
 .../userspace-api/media/v4l/pixfmt-nv12m.rst          |  9 +--------
 .../userspace-api/media/v4l/pixfmt-nv12mt.rst         |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-nv16.rst |  9 +--------
 .../userspace-api/media/v4l/pixfmt-nv16m.rst          |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-nv24.rst |  9 +--------
 .../userspace-api/media/v4l/pixfmt-packed-hsv.rst     |  9 +--------
 .../userspace-api/media/v4l/pixfmt-packed-yuv.rst     |  9 +--------
 .../userspace-api/media/v4l/pixfmt-reserved.rst       |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-rgb.rst  |  9 +--------
 .../userspace-api/media/v4l/pixfmt-sdr-cs08.rst       |  9 +--------
 .../userspace-api/media/v4l/pixfmt-sdr-cs14le.rst     |  9 +--------
 .../userspace-api/media/v4l/pixfmt-sdr-cu08.rst       |  9 +--------
 .../userspace-api/media/v4l/pixfmt-sdr-cu16le.rst     |  9 +--------
 .../userspace-api/media/v4l/pixfmt-sdr-pcu16be.rst    |  9 +--------
 .../userspace-api/media/v4l/pixfmt-sdr-pcu18be.rst    |  9 +--------
 .../userspace-api/media/v4l/pixfmt-sdr-pcu20be.rst    |  9 +--------
 .../userspace-api/media/v4l/pixfmt-sdr-ru12le.rst     |  9 +--------
 .../userspace-api/media/v4l/pixfmt-srggb10-ipu3.rst   |  9 +--------
 .../userspace-api/media/v4l/pixfmt-srggb10.rst        |  9 +--------
 .../userspace-api/media/v4l/pixfmt-srggb10alaw8.rst   |  9 +--------
 .../userspace-api/media/v4l/pixfmt-srggb10dpcm8.rst   |  9 +--------
 .../userspace-api/media/v4l/pixfmt-srggb10p.rst       |  9 +--------
 .../userspace-api/media/v4l/pixfmt-srggb12.rst        |  9 +--------
 .../userspace-api/media/v4l/pixfmt-srggb12p.rst       |  9 +--------
 .../userspace-api/media/v4l/pixfmt-srggb14.rst        |  9 +--------
 .../userspace-api/media/v4l/pixfmt-srggb14p.rst       |  9 +--------
 .../userspace-api/media/v4l/pixfmt-srggb16.rst        |  9 +--------
 .../userspace-api/media/v4l/pixfmt-srggb8.rst         |  9 +--------
 .../userspace-api/media/v4l/pixfmt-tch-td08.rst       |  9 +--------
 .../userspace-api/media/v4l/pixfmt-tch-td16.rst       |  9 +--------
 .../userspace-api/media/v4l/pixfmt-tch-tu08.rst       |  9 +--------
 .../userspace-api/media/v4l/pixfmt-tch-tu16.rst       |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-uv8.rst  |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-uyvy.rst |  9 +--------
 .../userspace-api/media/v4l/pixfmt-v4l2-mplane.rst    |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-v4l2.rst |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-vyuy.rst |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-y10.rst  |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-y10b.rst |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-y10p.rst |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-y12.rst  |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-y12i.rst |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-y14.rst  |  9 +--------
 .../userspace-api/media/v4l/pixfmt-y16-be.rst         |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-y16.rst  |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-y41p.rst |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-y8i.rst  |  9 +--------
 .../userspace-api/media/v4l/pixfmt-yuv410.rst         |  9 +--------
 .../userspace-api/media/v4l/pixfmt-yuv411p.rst        |  9 +--------
 .../userspace-api/media/v4l/pixfmt-yuv420.rst         |  9 +--------
 .../userspace-api/media/v4l/pixfmt-yuv420m.rst        |  9 +--------
 .../userspace-api/media/v4l/pixfmt-yuv422m.rst        |  9 +--------
 .../userspace-api/media/v4l/pixfmt-yuv422p.rst        |  9 +--------
 .../userspace-api/media/v4l/pixfmt-yuv444m.rst        |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-yuyv.rst |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-yvyu.rst |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt-z16.rst  |  9 +--------
 Documentation/userspace-api/media/v4l/pixfmt.rst      |  9 +--------
 Documentation/userspace-api/media/v4l/planar-apis.rst |  9 +--------
 Documentation/userspace-api/media/v4l/querycap.rst    |  9 +--------
 Documentation/userspace-api/media/v4l/rw.rst          |  9 +--------
 Documentation/userspace-api/media/v4l/sdr-formats.rst |  9 +--------
 .../media/v4l/selection-api-configuration.rst         |  9 +--------
 .../media/v4l/selection-api-examples.rst              |  9 +--------
 .../userspace-api/media/v4l/selection-api-intro.rst   |  9 +--------
 .../userspace-api/media/v4l/selection-api-targets.rst |  9 +--------
 .../media/v4l/selection-api-vs-crop-api.rst           |  9 +--------
 .../userspace-api/media/v4l/selection-api.rst         |  9 +--------
 .../userspace-api/media/v4l/selections-common.rst     |  9 +--------
 Documentation/userspace-api/media/v4l/standard.rst    |  9 +--------
 .../userspace-api/media/v4l/streaming-par.rst         |  9 +--------
 .../userspace-api/media/v4l/subdev-formats.rst        |  9 +--------
 Documentation/userspace-api/media/v4l/tch-formats.rst |  9 +--------
 Documentation/userspace-api/media/v4l/tuner.rst       |  9 +--------
 Documentation/userspace-api/media/v4l/user-func.rst   |  9 +--------
 Documentation/userspace-api/media/v4l/userp.rst       |  9 +--------
 .../userspace-api/media/v4l/v4l2-selection-flags.rst  |  9 +--------
 .../media/v4l/v4l2-selection-targets.rst              |  9 +--------
 Documentation/userspace-api/media/v4l/v4l2.rst        | 11 ++---------
 .../userspace-api/media/v4l/v4l2grab-example.rst      |  9 +--------
 Documentation/userspace-api/media/v4l/v4l2grab.c.rst  |  9 +--------
 Documentation/userspace-api/media/v4l/video.rst       |  9 +--------
 Documentation/userspace-api/media/v4l/videodev.rst    |  9 +--------
 .../userspace-api/media/v4l/vidioc-create-bufs.rst    |  9 +--------
 .../userspace-api/media/v4l/vidioc-cropcap.rst        |  9 +--------
 .../media/v4l/vidioc-dbg-g-chip-info.rst              |  9 +--------
 .../userspace-api/media/v4l/vidioc-dbg-g-register.rst |  9 +--------
 .../userspace-api/media/v4l/vidioc-decoder-cmd.rst    |  9 +--------
 .../userspace-api/media/v4l/vidioc-dqevent.rst        |  9 +--------
 .../userspace-api/media/v4l/vidioc-dv-timings-cap.rst |  9 +--------
 .../userspace-api/media/v4l/vidioc-encoder-cmd.rst    |  9 +--------
 .../media/v4l/vidioc-enum-dv-timings.rst              |  9 +--------
 .../userspace-api/media/v4l/vidioc-enum-fmt.rst       |  9 +--------
 .../media/v4l/vidioc-enum-frameintervals.rst          |  9 +--------
 .../media/v4l/vidioc-enum-framesizes.rst              |  9 +--------
 .../media/v4l/vidioc-enum-freq-bands.rst              |  9 +--------
 .../userspace-api/media/v4l/vidioc-enumaudio.rst      |  9 +--------
 .../userspace-api/media/v4l/vidioc-enumaudioout.rst   |  9 +--------
 .../userspace-api/media/v4l/vidioc-enuminput.rst      |  9 +--------
 .../userspace-api/media/v4l/vidioc-enumoutput.rst     |  9 +--------
 .../userspace-api/media/v4l/vidioc-enumstd.rst        |  9 +--------
 .../userspace-api/media/v4l/vidioc-expbuf.rst         |  9 +--------
 .../userspace-api/media/v4l/vidioc-g-audio.rst        |  9 +--------
 .../userspace-api/media/v4l/vidioc-g-audioout.rst     |  9 +--------
 .../userspace-api/media/v4l/vidioc-g-crop.rst         |  9 +--------
 .../userspace-api/media/v4l/vidioc-g-ctrl.rst         |  9 +--------
 .../userspace-api/media/v4l/vidioc-g-dv-timings.rst   |  9 +--------
 .../userspace-api/media/v4l/vidioc-g-edid.rst         |  9 +--------
 .../userspace-api/media/v4l/vidioc-g-enc-index.rst    |  9 +--------
 .../userspace-api/media/v4l/vidioc-g-ext-ctrls.rst    |  9 +--------
 .../userspace-api/media/v4l/vidioc-g-fbuf.rst         |  9 +--------
 .../userspace-api/media/v4l/vidioc-g-fmt.rst          |  9 +--------
 .../userspace-api/media/v4l/vidioc-g-frequency.rst    |  9 +--------
 .../userspace-api/media/v4l/vidioc-g-input.rst        |  9 +--------
 .../userspace-api/media/v4l/vidioc-g-jpegcomp.rst     |  9 +--------
 .../userspace-api/media/v4l/vidioc-g-modulator.rst    |  9 +--------
 .../userspace-api/media/v4l/vidioc-g-output.rst       |  9 +--------
 .../userspace-api/media/v4l/vidioc-g-parm.rst         |  9 +--------
 .../userspace-api/media/v4l/vidioc-g-priority.rst     |  9 +--------
 .../userspace-api/media/v4l/vidioc-g-selection.rst    |  9 +--------
 .../media/v4l/vidioc-g-sliced-vbi-cap.rst             |  9 +--------
 .../userspace-api/media/v4l/vidioc-g-std.rst          |  9 +--------
 .../userspace-api/media/v4l/vidioc-g-tuner.rst        |  9 +--------
 .../userspace-api/media/v4l/vidioc-log-status.rst     |  9 +--------
 .../userspace-api/media/v4l/vidioc-overlay.rst        |  9 +--------
 .../userspace-api/media/v4l/vidioc-prepare-buf.rst    |  9 +--------
 Documentation/userspace-api/media/v4l/vidioc-qbuf.rst |  9 +--------
 .../media/v4l/vidioc-query-dv-timings.rst             |  9 +--------
 .../userspace-api/media/v4l/vidioc-querybuf.rst       |  9 +--------
 .../userspace-api/media/v4l/vidioc-querycap.rst       |  9 +--------
 .../userspace-api/media/v4l/vidioc-queryctrl.rst      |  9 +--------
 .../userspace-api/media/v4l/vidioc-querystd.rst       |  9 +--------
 .../userspace-api/media/v4l/vidioc-reqbufs.rst        |  9 +--------
 .../userspace-api/media/v4l/vidioc-s-hw-freq-seek.rst |  9 +--------
 .../userspace-api/media/v4l/vidioc-streamon.rst       |  9 +--------
 .../media/v4l/vidioc-subdev-enum-frame-interval.rst   |  9 +--------
 .../media/v4l/vidioc-subdev-enum-frame-size.rst       |  9 +--------
 .../media/v4l/vidioc-subdev-enum-mbus-code.rst        |  9 +--------
 .../userspace-api/media/v4l/vidioc-subdev-g-crop.rst  |  9 +--------
 .../userspace-api/media/v4l/vidioc-subdev-g-fmt.rst   |  9 +--------
 .../media/v4l/vidioc-subdev-g-frame-interval.rst      |  9 +--------
 .../media/v4l/vidioc-subdev-g-selection.rst           |  9 +--------
 .../media/v4l/vidioc-subdev-querycap.rst              |  9 +--------
 .../media/v4l/vidioc-subscribe-event.rst              |  9 +--------
 Documentation/userspace-api/media/v4l/yuv-formats.rst |  9 +--------
 411 files changed, 412 insertions(+), 3288 deletions(-)

diff --git a/Documentation/userspace-api/media/cec/cec-api.rst b/Documentation/userspace-api/media/cec/cec-api.rst
index 871db54dfd24..4d229ed8a1d9 100644
--- a/Documentation/userspace-api/media/cec/cec-api.rst
+++ b/Documentation/userspace-api/media/cec/cec-api.rst
@@ -1,12 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
-
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 .. include:: <isonum.txt>
 
 .. _cec:
diff --git a/Documentation/userspace-api/media/cec/cec-func-close.rst b/Documentation/userspace-api/media/cec/cec-func-close.rst
index b89e06a43dad..33c563f414a8 100644
--- a/Documentation/userspace-api/media/cec/cec-func-close.rst
+++ b/Documentation/userspace-api/media/cec/cec-func-close.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _cec-func-close:
 
diff --git a/Documentation/userspace-api/media/cec/cec-func-ioctl.rst b/Documentation/userspace-api/media/cec/cec-func-ioctl.rst
index d16a479aacb1..3b88230fad80 100644
--- a/Documentation/userspace-api/media/cec/cec-func-ioctl.rst
+++ b/Documentation/userspace-api/media/cec/cec-func-ioctl.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _cec-func-ioctl:
 
diff --git a/Documentation/userspace-api/media/cec/cec-func-open.rst b/Documentation/userspace-api/media/cec/cec-func-open.rst
index 67fd021556b2..887bfd2a755e 100644
--- a/Documentation/userspace-api/media/cec/cec-func-open.rst
+++ b/Documentation/userspace-api/media/cec/cec-func-open.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _cec-func-open:
 
diff --git a/Documentation/userspace-api/media/cec/cec-func-poll.rst b/Documentation/userspace-api/media/cec/cec-func-poll.rst
index ed3652d9bf17..2d87136e9a3f 100644
--- a/Documentation/userspace-api/media/cec/cec-func-poll.rst
+++ b/Documentation/userspace-api/media/cec/cec-func-poll.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _cec-func-poll:
 
diff --git a/Documentation/userspace-api/media/cec/cec-funcs.rst b/Documentation/userspace-api/media/cec/cec-funcs.rst
index 88966b5175d2..aa6b790e8400 100644
--- a/Documentation/userspace-api/media/cec/cec-funcs.rst
+++ b/Documentation/userspace-api/media/cec/cec-funcs.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _cec-user-func:
 
diff --git a/Documentation/userspace-api/media/cec/cec-header.rst b/Documentation/userspace-api/media/cec/cec-header.rst
index 24a83b0c35af..d70736ac2b1d 100644
--- a/Documentation/userspace-api/media/cec/cec-header.rst
+++ b/Documentation/userspace-api/media/cec/cec-header.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _cec_header:
 
diff --git a/Documentation/userspace-api/media/cec/cec-intro.rst b/Documentation/userspace-api/media/cec/cec-intro.rst
index a4db82388202..1884ea090f12 100644
--- a/Documentation/userspace-api/media/cec/cec-intro.rst
+++ b/Documentation/userspace-api/media/cec/cec-intro.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _cec-intro:
 
diff --git a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
index 436a882dfa31..7f25365ce0fb 100644
--- a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
+++ b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _CEC_ADAP_G_CAPS:
 
diff --git a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-addrs.rst b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-addrs.rst
index 8ba3511c88b8..1ca893270ae9 100644
--- a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-addrs.rst
+++ b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-addrs.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _CEC_ADAP_LOG_ADDRS:
 .. _CEC_ADAP_G_LOG_ADDRS:
diff --git a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-phys-addr.rst b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-phys-addr.rst
index ce8f64c3e060..a10443be1b26 100644
--- a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-phys-addr.rst
+++ b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-phys-addr.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _CEC_ADAP_PHYS_ADDR:
 .. _CEC_ADAP_G_PHYS_ADDR:
diff --git a/Documentation/userspace-api/media/cec/cec-ioc-dqevent.rst b/Documentation/userspace-api/media/cec/cec-ioc-dqevent.rst
index 4a535fb64b4b..3bc81fc5a73f 100644
--- a/Documentation/userspace-api/media/cec/cec-ioc-dqevent.rst
+++ b/Documentation/userspace-api/media/cec/cec-ioc-dqevent.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _CEC_DQEVENT:
 
diff --git a/Documentation/userspace-api/media/cec/cec-ioc-g-mode.rst b/Documentation/userspace-api/media/cec/cec-ioc-g-mode.rst
index 2d3227e80b4f..2093e373c93c 100644
--- a/Documentation/userspace-api/media/cec/cec-ioc-g-mode.rst
+++ b/Documentation/userspace-api/media/cec/cec-ioc-g-mode.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _CEC_MODE:
 .. _CEC_G_MODE:
diff --git a/Documentation/userspace-api/media/cec/cec-ioc-receive.rst b/Documentation/userspace-api/media/cec/cec-ioc-receive.rst
index e456b2bc92a1..9d629d46973c 100644
--- a/Documentation/userspace-api/media/cec/cec-ioc-receive.rst
+++ b/Documentation/userspace-api/media/cec/cec-ioc-receive.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _CEC_TRANSMIT:
 .. _CEC_RECEIVE:
diff --git a/Documentation/userspace-api/media/cec/cec-pin-error-inj.rst b/Documentation/userspace-api/media/cec/cec-pin-error-inj.rst
index 78632199324d..064c8c5a1943 100644
--- a/Documentation/userspace-api/media/cec/cec-pin-error-inj.rst
+++ b/Documentation/userspace-api/media/cec/cec-pin-error-inj.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 CEC Pin Framework Error Injection
 =================================
diff --git a/Documentation/userspace-api/media/dvb/audio-bilingual-channel-select.rst b/Documentation/userspace-api/media/dvb/audio-bilingual-channel-select.rst
index 6841233f3fee..ba4f48b30d29 100644
--- a/Documentation/userspace-api/media/dvb/audio-bilingual-channel-select.rst
+++ b/Documentation/userspace-api/media/dvb/audio-bilingual-channel-select.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _AUDIO_BILINGUAL_CHANNEL_SELECT:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-channel-select.rst b/Documentation/userspace-api/media/dvb/audio-channel-select.rst
index 18e880e7eab4..ba83b639d955 100644
--- a/Documentation/userspace-api/media/dvb/audio-channel-select.rst
+++ b/Documentation/userspace-api/media/dvb/audio-channel-select.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _AUDIO_CHANNEL_SELECT:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-clear-buffer.rst b/Documentation/userspace-api/media/dvb/audio-clear-buffer.rst
index 19f2ed752ce2..7035a40c0e3a 100644
--- a/Documentation/userspace-api/media/dvb/audio-clear-buffer.rst
+++ b/Documentation/userspace-api/media/dvb/audio-clear-buffer.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _AUDIO_CLEAR_BUFFER:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-continue.rst b/Documentation/userspace-api/media/dvb/audio-continue.rst
index b9a2b1e608b6..c8d514a4eeb0 100644
--- a/Documentation/userspace-api/media/dvb/audio-continue.rst
+++ b/Documentation/userspace-api/media/dvb/audio-continue.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _AUDIO_CONTINUE:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-fclose.rst b/Documentation/userspace-api/media/dvb/audio-fclose.rst
index 448471d2f570..c968177b1e3f 100644
--- a/Documentation/userspace-api/media/dvb/audio-fclose.rst
+++ b/Documentation/userspace-api/media/dvb/audio-fclose.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _audio_fclose:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-fopen.rst b/Documentation/userspace-api/media/dvb/audio-fopen.rst
index f7ae94378f92..d34001e038dc 100644
--- a/Documentation/userspace-api/media/dvb/audio-fopen.rst
+++ b/Documentation/userspace-api/media/dvb/audio-fopen.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _audio_fopen:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-fwrite.rst b/Documentation/userspace-api/media/dvb/audio-fwrite.rst
index 1482636f9b1a..d17ec719e231 100644
--- a/Documentation/userspace-api/media/dvb/audio-fwrite.rst
+++ b/Documentation/userspace-api/media/dvb/audio-fwrite.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _audio_fwrite:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-get-capabilities.rst b/Documentation/userspace-api/media/dvb/audio-get-capabilities.rst
index 4e70d82969ad..33907e40e48c 100644
--- a/Documentation/userspace-api/media/dvb/audio-get-capabilities.rst
+++ b/Documentation/userspace-api/media/dvb/audio-get-capabilities.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _AUDIO_GET_CAPABILITIES:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-get-status.rst b/Documentation/userspace-api/media/dvb/audio-get-status.rst
index 5a5180d642d4..4213d076c6ed 100644
--- a/Documentation/userspace-api/media/dvb/audio-get-status.rst
+++ b/Documentation/userspace-api/media/dvb/audio-get-status.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _AUDIO_GET_STATUS:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-pause.rst b/Documentation/userspace-api/media/dvb/audio-pause.rst
index 3e9fe06d3a0f..2de74f1662cf 100644
--- a/Documentation/userspace-api/media/dvb/audio-pause.rst
+++ b/Documentation/userspace-api/media/dvb/audio-pause.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _AUDIO_PAUSE:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-play.rst b/Documentation/userspace-api/media/dvb/audio-play.rst
index 388a581a19f2..d4e4eacb8686 100644
--- a/Documentation/userspace-api/media/dvb/audio-play.rst
+++ b/Documentation/userspace-api/media/dvb/audio-play.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _AUDIO_PLAY:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-select-source.rst b/Documentation/userspace-api/media/dvb/audio-select-source.rst
index 1ce64507de93..fb09f914cb8f 100644
--- a/Documentation/userspace-api/media/dvb/audio-select-source.rst
+++ b/Documentation/userspace-api/media/dvb/audio-select-source.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _AUDIO_SELECT_SOURCE:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-set-av-sync.rst b/Documentation/userspace-api/media/dvb/audio-set-av-sync.rst
index 3a0400dcfae4..5bcb9b1ed19d 100644
--- a/Documentation/userspace-api/media/dvb/audio-set-av-sync.rst
+++ b/Documentation/userspace-api/media/dvb/audio-set-av-sync.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _AUDIO_SET_AV_SYNC:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-set-bypass-mode.rst b/Documentation/userspace-api/media/dvb/audio-set-bypass-mode.rst
index 0d2f23cc2f16..f24a18bbb567 100644
--- a/Documentation/userspace-api/media/dvb/audio-set-bypass-mode.rst
+++ b/Documentation/userspace-api/media/dvb/audio-set-bypass-mode.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _AUDIO_SET_BYPASS_MODE:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-set-id.rst b/Documentation/userspace-api/media/dvb/audio-set-id.rst
index 83fc1217fda0..0227e1071d0c 100644
--- a/Documentation/userspace-api/media/dvb/audio-set-id.rst
+++ b/Documentation/userspace-api/media/dvb/audio-set-id.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _AUDIO_SET_ID:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-set-mixer.rst b/Documentation/userspace-api/media/dvb/audio-set-mixer.rst
index 52bfc3af79dc..58f18cf8240d 100644
--- a/Documentation/userspace-api/media/dvb/audio-set-mixer.rst
+++ b/Documentation/userspace-api/media/dvb/audio-set-mixer.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _AUDIO_SET_MIXER:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-set-mute.rst b/Documentation/userspace-api/media/dvb/audio-set-mute.rst
index 8f3a8332cebc..7ea7d8663e6b 100644
--- a/Documentation/userspace-api/media/dvb/audio-set-mute.rst
+++ b/Documentation/userspace-api/media/dvb/audio-set-mute.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _AUDIO_SET_MUTE:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-set-streamtype.rst b/Documentation/userspace-api/media/dvb/audio-set-streamtype.rst
index c22bd247f03d..d9f4924afdbe 100644
--- a/Documentation/userspace-api/media/dvb/audio-set-streamtype.rst
+++ b/Documentation/userspace-api/media/dvb/audio-set-streamtype.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _AUDIO_SET_STREAMTYPE:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-stop.rst b/Documentation/userspace-api/media/dvb/audio-stop.rst
index 291b6a42efac..3a2bc328626d 100644
--- a/Documentation/userspace-api/media/dvb/audio-stop.rst
+++ b/Documentation/userspace-api/media/dvb/audio-stop.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _AUDIO_STOP:
 
diff --git a/Documentation/userspace-api/media/dvb/audio.rst b/Documentation/userspace-api/media/dvb/audio.rst
index e137c151335d..071abac9d52d 100644
--- a/Documentation/userspace-api/media/dvb/audio.rst
+++ b/Documentation/userspace-api/media/dvb/audio.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _dvb_audio:
 
diff --git a/Documentation/userspace-api/media/dvb/audio_data_types.rst b/Documentation/userspace-api/media/dvb/audio_data_types.rst
index effe265b12d5..4744529136a8 100644
--- a/Documentation/userspace-api/media/dvb/audio_data_types.rst
+++ b/Documentation/userspace-api/media/dvb/audio_data_types.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _audio_data_types:
 
diff --git a/Documentation/userspace-api/media/dvb/audio_function_calls.rst b/Documentation/userspace-api/media/dvb/audio_function_calls.rst
index be90a828fe29..fa5ba9539caf 100644
--- a/Documentation/userspace-api/media/dvb/audio_function_calls.rst
+++ b/Documentation/userspace-api/media/dvb/audio_function_calls.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _audio_function_calls:
 
diff --git a/Documentation/userspace-api/media/dvb/ca-fclose.rst b/Documentation/userspace-api/media/dvb/ca-fclose.rst
index cedfb7ee6a01..00379ee7e9ed 100644
--- a/Documentation/userspace-api/media/dvb/ca-fclose.rst
+++ b/Documentation/userspace-api/media/dvb/ca-fclose.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _ca_fclose:
 
diff --git a/Documentation/userspace-api/media/dvb/ca-fopen.rst b/Documentation/userspace-api/media/dvb/ca-fopen.rst
index aa0fde1739a8..9ca4bd1d8d5f 100644
--- a/Documentation/userspace-api/media/dvb/ca-fopen.rst
+++ b/Documentation/userspace-api/media/dvb/ca-fopen.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _ca_fopen:
 
diff --git a/Documentation/userspace-api/media/dvb/ca-get-cap.rst b/Documentation/userspace-api/media/dvb/ca-get-cap.rst
index b808d0592371..93742a5d941d 100644
--- a/Documentation/userspace-api/media/dvb/ca-get-cap.rst
+++ b/Documentation/userspace-api/media/dvb/ca-get-cap.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _CA_GET_CAP:
 
diff --git a/Documentation/userspace-api/media/dvb/ca-get-descr-info.rst b/Documentation/userspace-api/media/dvb/ca-get-descr-info.rst
index 396cc66a8243..be7dec053685 100644
--- a/Documentation/userspace-api/media/dvb/ca-get-descr-info.rst
+++ b/Documentation/userspace-api/media/dvb/ca-get-descr-info.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _CA_GET_DESCR_INFO:
 
diff --git a/Documentation/userspace-api/media/dvb/ca-get-msg.rst b/Documentation/userspace-api/media/dvb/ca-get-msg.rst
index 995f461d6879..e8802b4c5fa1 100644
--- a/Documentation/userspace-api/media/dvb/ca-get-msg.rst
+++ b/Documentation/userspace-api/media/dvb/ca-get-msg.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _CA_GET_MSG:
 
diff --git a/Documentation/userspace-api/media/dvb/ca-get-slot-info.rst b/Documentation/userspace-api/media/dvb/ca-get-slot-info.rst
index c65987ff9cb3..d283df335914 100644
--- a/Documentation/userspace-api/media/dvb/ca-get-slot-info.rst
+++ b/Documentation/userspace-api/media/dvb/ca-get-slot-info.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _CA_GET_SLOT_INFO:
 
diff --git a/Documentation/userspace-api/media/dvb/ca-reset.rst b/Documentation/userspace-api/media/dvb/ca-reset.rst
index 116a5a8eeb5d..fc49ef2ffcdb 100644
--- a/Documentation/userspace-api/media/dvb/ca-reset.rst
+++ b/Documentation/userspace-api/media/dvb/ca-reset.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _CA_RESET:
 
diff --git a/Documentation/userspace-api/media/dvb/ca-send-msg.rst b/Documentation/userspace-api/media/dvb/ca-send-msg.rst
index 716d88e0fdc5..cf423fe881b8 100644
--- a/Documentation/userspace-api/media/dvb/ca-send-msg.rst
+++ b/Documentation/userspace-api/media/dvb/ca-send-msg.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _CA_SEND_MSG:
 
diff --git a/Documentation/userspace-api/media/dvb/ca-set-descr.rst b/Documentation/userspace-api/media/dvb/ca-set-descr.rst
index 2c57371675e2..a5c628a4d3cd 100644
--- a/Documentation/userspace-api/media/dvb/ca-set-descr.rst
+++ b/Documentation/userspace-api/media/dvb/ca-set-descr.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _CA_SET_DESCR:
 
diff --git a/Documentation/userspace-api/media/dvb/ca.rst b/Documentation/userspace-api/media/dvb/ca.rst
index 643b7c414943..6f6821e322a9 100644
--- a/Documentation/userspace-api/media/dvb/ca.rst
+++ b/Documentation/userspace-api/media/dvb/ca.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _dvb_ca:
 
diff --git a/Documentation/userspace-api/media/dvb/ca_data_types.rst b/Documentation/userspace-api/media/dvb/ca_data_types.rst
index 20e2b552144f..54ea2a987546 100644
--- a/Documentation/userspace-api/media/dvb/ca_data_types.rst
+++ b/Documentation/userspace-api/media/dvb/ca_data_types.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _ca_data_types:
 
diff --git a/Documentation/userspace-api/media/dvb/ca_function_calls.rst b/Documentation/userspace-api/media/dvb/ca_function_calls.rst
index b8aceb1895b6..3b893fbd502d 100644
--- a/Documentation/userspace-api/media/dvb/ca_function_calls.rst
+++ b/Documentation/userspace-api/media/dvb/ca_function_calls.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _ca_function_calls:
 
diff --git a/Documentation/userspace-api/media/dvb/demux.rst b/Documentation/userspace-api/media/dvb/demux.rst
index 00397b075e0f..364ef48472ee 100644
--- a/Documentation/userspace-api/media/dvb/demux.rst
+++ b/Documentation/userspace-api/media/dvb/demux.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _dvb_demux:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-add-pid.rst b/Documentation/userspace-api/media/dvb/dmx-add-pid.rst
index e309cd56fdf0..3f08ecd88b0c 100644
--- a/Documentation/userspace-api/media/dvb/dmx-add-pid.rst
+++ b/Documentation/userspace-api/media/dvb/dmx-add-pid.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _DMX_ADD_PID:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-expbuf.rst b/Documentation/userspace-api/media/dvb/dmx-expbuf.rst
index f76db8ce3cfa..cde2b78a35fa 100644
--- a/Documentation/userspace-api/media/dvb/dmx-expbuf.rst
+++ b/Documentation/userspace-api/media/dvb/dmx-expbuf.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _DMX_EXPBUF:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-fclose.rst b/Documentation/userspace-api/media/dvb/dmx-fclose.rst
index e93bc60da508..af036792f13d 100644
--- a/Documentation/userspace-api/media/dvb/dmx-fclose.rst
+++ b/Documentation/userspace-api/media/dvb/dmx-fclose.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _dmx_fclose:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-fopen.rst b/Documentation/userspace-api/media/dvb/dmx-fopen.rst
index ea988714558e..7117c9bc4325 100644
--- a/Documentation/userspace-api/media/dvb/dmx-fopen.rst
+++ b/Documentation/userspace-api/media/dvb/dmx-fopen.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _dmx_fopen:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-fread.rst b/Documentation/userspace-api/media/dvb/dmx-fread.rst
index 25501be818f8..c708a240abae 100644
--- a/Documentation/userspace-api/media/dvb/dmx-fread.rst
+++ b/Documentation/userspace-api/media/dvb/dmx-fread.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _dmx_fread:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-fwrite.rst b/Documentation/userspace-api/media/dvb/dmx-fwrite.rst
index 4400f4ef8c65..bef565a35c59 100644
--- a/Documentation/userspace-api/media/dvb/dmx-fwrite.rst
+++ b/Documentation/userspace-api/media/dvb/dmx-fwrite.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _dmx_fwrite:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-get-pes-pids.rst b/Documentation/userspace-api/media/dvb/dmx-get-pes-pids.rst
index e1873e3fdc01..e92d94d93b18 100644
--- a/Documentation/userspace-api/media/dvb/dmx-get-pes-pids.rst
+++ b/Documentation/userspace-api/media/dvb/dmx-get-pes-pids.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _DMX_GET_PES_PIDS:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-get-stc.rst b/Documentation/userspace-api/media/dvb/dmx-get-stc.rst
index 026a884edb0a..3762efcf1355 100644
--- a/Documentation/userspace-api/media/dvb/dmx-get-stc.rst
+++ b/Documentation/userspace-api/media/dvb/dmx-get-stc.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _DMX_GET_STC:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-mmap.rst b/Documentation/userspace-api/media/dvb/dmx-mmap.rst
index 828ba9df73e2..efa9b04be700 100644
--- a/Documentation/userspace-api/media/dvb/dmx-mmap.rst
+++ b/Documentation/userspace-api/media/dvb/dmx-mmap.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _dmx-mmap:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-munmap.rst b/Documentation/userspace-api/media/dvb/dmx-munmap.rst
index 905fdd585a86..308a9593919c 100644
--- a/Documentation/userspace-api/media/dvb/dmx-munmap.rst
+++ b/Documentation/userspace-api/media/dvb/dmx-munmap.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _dmx-munmap:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-qbuf.rst b/Documentation/userspace-api/media/dvb/dmx-qbuf.rst
index 2c4657c2c86d..fcb1c55dd49a 100644
--- a/Documentation/userspace-api/media/dvb/dmx-qbuf.rst
+++ b/Documentation/userspace-api/media/dvb/dmx-qbuf.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _DMX_QBUF:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-querybuf.rst b/Documentation/userspace-api/media/dvb/dmx-querybuf.rst
index 6e234daf1c44..df13e2b053c9 100644
--- a/Documentation/userspace-api/media/dvb/dmx-querybuf.rst
+++ b/Documentation/userspace-api/media/dvb/dmx-querybuf.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _DMX_QUERYBUF:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-remove-pid.rst b/Documentation/userspace-api/media/dvb/dmx-remove-pid.rst
index dee553a48b63..ce408d0d7c77 100644
--- a/Documentation/userspace-api/media/dvb/dmx-remove-pid.rst
+++ b/Documentation/userspace-api/media/dvb/dmx-remove-pid.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _DMX_REMOVE_PID:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-reqbufs.rst b/Documentation/userspace-api/media/dvb/dmx-reqbufs.rst
index 9b9be45d2b0b..433aed632f92 100644
--- a/Documentation/userspace-api/media/dvb/dmx-reqbufs.rst
+++ b/Documentation/userspace-api/media/dvb/dmx-reqbufs.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _DMX_REQBUFS:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-set-buffer-size.rst b/Documentation/userspace-api/media/dvb/dmx-set-buffer-size.rst
index 7c91da1da4be..e803cbab220b 100644
--- a/Documentation/userspace-api/media/dvb/dmx-set-buffer-size.rst
+++ b/Documentation/userspace-api/media/dvb/dmx-set-buffer-size.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _DMX_SET_BUFFER_SIZE:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-set-filter.rst b/Documentation/userspace-api/media/dvb/dmx-set-filter.rst
index cb3333349bd0..4cd3db512b4e 100644
--- a/Documentation/userspace-api/media/dvb/dmx-set-filter.rst
+++ b/Documentation/userspace-api/media/dvb/dmx-set-filter.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _DMX_SET_FILTER:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-set-pes-filter.rst b/Documentation/userspace-api/media/dvb/dmx-set-pes-filter.rst
index 26da56947652..8e54fd2636ed 100644
--- a/Documentation/userspace-api/media/dvb/dmx-set-pes-filter.rst
+++ b/Documentation/userspace-api/media/dvb/dmx-set-pes-filter.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _DMX_SET_PES_FILTER:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-start.rst b/Documentation/userspace-api/media/dvb/dmx-start.rst
index a1d35f01fc95..6f1413e13936 100644
--- a/Documentation/userspace-api/media/dvb/dmx-start.rst
+++ b/Documentation/userspace-api/media/dvb/dmx-start.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _DMX_START:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-stop.rst b/Documentation/userspace-api/media/dvb/dmx-stop.rst
index 5e6e805010d0..cbc3956fd71d 100644
--- a/Documentation/userspace-api/media/dvb/dmx-stop.rst
+++ b/Documentation/userspace-api/media/dvb/dmx-stop.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _DMX_STOP:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx_fcalls.rst b/Documentation/userspace-api/media/dvb/dmx_fcalls.rst
index 04e150f00f84..a14e7a61f90b 100644
--- a/Documentation/userspace-api/media/dvb/dmx_fcalls.rst
+++ b/Documentation/userspace-api/media/dvb/dmx_fcalls.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _dmx_fcalls:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx_types.rst b/Documentation/userspace-api/media/dvb/dmx_types.rst
index 635b8fd363be..33458fbb84ab 100644
--- a/Documentation/userspace-api/media/dvb/dmx_types.rst
+++ b/Documentation/userspace-api/media/dvb/dmx_types.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _dmx_types:
 
diff --git a/Documentation/userspace-api/media/dvb/dvb-fe-read-status.rst b/Documentation/userspace-api/media/dvb/dvb-fe-read-status.rst
index 5d6a7735a9d1..fbd0548f5fb9 100644
--- a/Documentation/userspace-api/media/dvb/dvb-fe-read-status.rst
+++ b/Documentation/userspace-api/media/dvb/dvb-fe-read-status.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _dvb-fe-read-status:
 
diff --git a/Documentation/userspace-api/media/dvb/dvb-frontend-event.rst b/Documentation/userspace-api/media/dvb/dvb-frontend-event.rst
index 7f5e56cf75cb..0e2fd3a0a7c0 100644
--- a/Documentation/userspace-api/media/dvb/dvb-frontend-event.rst
+++ b/Documentation/userspace-api/media/dvb/dvb-frontend-event.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. c:type:: dvb_frontend_event
 
diff --git a/Documentation/userspace-api/media/dvb/dvb-frontend-parameters.rst b/Documentation/userspace-api/media/dvb/dvb-frontend-parameters.rst
index 83b1bcc6ef54..9dd2f542441e 100644
--- a/Documentation/userspace-api/media/dvb/dvb-frontend-parameters.rst
+++ b/Documentation/userspace-api/media/dvb/dvb-frontend-parameters.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. c:type:: dvb_frontend_parameters
 
diff --git a/Documentation/userspace-api/media/dvb/dvbapi.rst b/Documentation/userspace-api/media/dvb/dvbapi.rst
index 74b16ab3fd94..1dda69343f34 100644
--- a/Documentation/userspace-api/media/dvb/dvbapi.rst
+++ b/Documentation/userspace-api/media/dvb/dvbapi.rst
@@ -1,12 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
-
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 .. include:: <isonum.txt>
 
 .. _dvbapi:
diff --git a/Documentation/userspace-api/media/dvb/dvbproperty.rst b/Documentation/userspace-api/media/dvb/dvbproperty.rst
index 1716733d24ba..981da20afd49 100644
--- a/Documentation/userspace-api/media/dvb/dvbproperty.rst
+++ b/Documentation/userspace-api/media/dvb/dvbproperty.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _frontend-properties:
 
diff --git a/Documentation/userspace-api/media/dvb/examples.rst b/Documentation/userspace-api/media/dvb/examples.rst
index bd0adde86b96..086587c65a57 100644
--- a/Documentation/userspace-api/media/dvb/examples.rst
+++ b/Documentation/userspace-api/media/dvb/examples.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _dvb_examples:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-bandwidth-t.rst b/Documentation/userspace-api/media/dvb/fe-bandwidth-t.rst
index 6293287af67c..904b0c33a3ec 100644
--- a/Documentation/userspace-api/media/dvb/fe-bandwidth-t.rst
+++ b/Documentation/userspace-api/media/dvb/fe-bandwidth-t.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 ******************
 Frontend bandwidth
diff --git a/Documentation/userspace-api/media/dvb/fe-diseqc-recv-slave-reply.rst b/Documentation/userspace-api/media/dvb/fe-diseqc-recv-slave-reply.rst
index b520974e8c46..115cced97e66 100644
--- a/Documentation/userspace-api/media/dvb/fe-diseqc-recv-slave-reply.rst
+++ b/Documentation/userspace-api/media/dvb/fe-diseqc-recv-slave-reply.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _FE_DISEQC_RECV_SLAVE_REPLY:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-diseqc-reset-overload.rst b/Documentation/userspace-api/media/dvb/fe-diseqc-reset-overload.rst
index c59af46b8e87..5ffc34a6496e 100644
--- a/Documentation/userspace-api/media/dvb/fe-diseqc-reset-overload.rst
+++ b/Documentation/userspace-api/media/dvb/fe-diseqc-reset-overload.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _FE_DISEQC_RESET_OVERLOAD:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-diseqc-send-burst.rst b/Documentation/userspace-api/media/dvb/fe-diseqc-send-burst.rst
index 19b51d0550f7..fd59afe814f3 100644
--- a/Documentation/userspace-api/media/dvb/fe-diseqc-send-burst.rst
+++ b/Documentation/userspace-api/media/dvb/fe-diseqc-send-burst.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _FE_DISEQC_SEND_BURST:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-diseqc-send-master-cmd.rst b/Documentation/userspace-api/media/dvb/fe-diseqc-send-master-cmd.rst
index f75513d018c8..faa2a8364e10 100644
--- a/Documentation/userspace-api/media/dvb/fe-diseqc-send-master-cmd.rst
+++ b/Documentation/userspace-api/media/dvb/fe-diseqc-send-master-cmd.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _FE_DISEQC_SEND_MASTER_CMD:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-dishnetwork-send-legacy-cmd.rst b/Documentation/userspace-api/media/dvb/fe-dishnetwork-send-legacy-cmd.rst
index ea66f72fe5f8..60d69bb6da71 100644
--- a/Documentation/userspace-api/media/dvb/fe-dishnetwork-send-legacy-cmd.rst
+++ b/Documentation/userspace-api/media/dvb/fe-dishnetwork-send-legacy-cmd.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _FE_DISHNETWORK_SEND_LEGACY_CMD:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-enable-high-lnb-voltage.rst b/Documentation/userspace-api/media/dvb/fe-enable-high-lnb-voltage.rst
index 9bdf1e898ddc..df0cc91384d9 100644
--- a/Documentation/userspace-api/media/dvb/fe-enable-high-lnb-voltage.rst
+++ b/Documentation/userspace-api/media/dvb/fe-enable-high-lnb-voltage.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _FE_ENABLE_HIGH_LNB_VOLTAGE:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-get-event.rst b/Documentation/userspace-api/media/dvb/fe-get-event.rst
index 19df41dca238..723bb3a4a630 100644
--- a/Documentation/userspace-api/media/dvb/fe-get-event.rst
+++ b/Documentation/userspace-api/media/dvb/fe-get-event.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _FE_GET_EVENT:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-get-frontend.rst b/Documentation/userspace-api/media/dvb/fe-get-frontend.rst
index 7968adc8e982..2bfc1f1a3dc5 100644
--- a/Documentation/userspace-api/media/dvb/fe-get-frontend.rst
+++ b/Documentation/userspace-api/media/dvb/fe-get-frontend.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _FE_GET_FRONTEND:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-get-info.rst b/Documentation/userspace-api/media/dvb/fe-get-info.rst
index 6b3ffd301142..eba115c03471 100644
--- a/Documentation/userspace-api/media/dvb/fe-get-info.rst
+++ b/Documentation/userspace-api/media/dvb/fe-get-info.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _FE_GET_INFO:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-get-property.rst b/Documentation/userspace-api/media/dvb/fe-get-property.rst
index 088d4e319405..10e1db172d8a 100644
--- a/Documentation/userspace-api/media/dvb/fe-get-property.rst
+++ b/Documentation/userspace-api/media/dvb/fe-get-property.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _FE_GET_PROPERTY:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-read-ber.rst b/Documentation/userspace-api/media/dvb/fe-read-ber.rst
index d0a706ac9011..2200eb1d06f9 100644
--- a/Documentation/userspace-api/media/dvb/fe-read-ber.rst
+++ b/Documentation/userspace-api/media/dvb/fe-read-ber.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _FE_READ_BER:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-read-signal-strength.rst b/Documentation/userspace-api/media/dvb/fe-read-signal-strength.rst
index df79837de47d..4832efad2a2e 100644
--- a/Documentation/userspace-api/media/dvb/fe-read-signal-strength.rst
+++ b/Documentation/userspace-api/media/dvb/fe-read-signal-strength.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _FE_READ_SIGNAL_STRENGTH:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-read-snr.rst b/Documentation/userspace-api/media/dvb/fe-read-snr.rst
index e56147a40e23..141e4fc661c2 100644
--- a/Documentation/userspace-api/media/dvb/fe-read-snr.rst
+++ b/Documentation/userspace-api/media/dvb/fe-read-snr.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _FE_READ_SNR:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-read-status.rst b/Documentation/userspace-api/media/dvb/fe-read-status.rst
index cf781d463a20..ba61feb5e535 100644
--- a/Documentation/userspace-api/media/dvb/fe-read-status.rst
+++ b/Documentation/userspace-api/media/dvb/fe-read-status.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _FE_READ_STATUS:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-read-uncorrected-blocks.rst b/Documentation/userspace-api/media/dvb/fe-read-uncorrected-blocks.rst
index d042e8c86930..bf9746f8a671 100644
--- a/Documentation/userspace-api/media/dvb/fe-read-uncorrected-blocks.rst
+++ b/Documentation/userspace-api/media/dvb/fe-read-uncorrected-blocks.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _FE_READ_UNCORRECTED_BLOCKS:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-set-frontend-tune-mode.rst b/Documentation/userspace-api/media/dvb/fe-set-frontend-tune-mode.rst
index 8e059967f49c..f0e178e3a180 100644
--- a/Documentation/userspace-api/media/dvb/fe-set-frontend-tune-mode.rst
+++ b/Documentation/userspace-api/media/dvb/fe-set-frontend-tune-mode.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _FE_SET_FRONTEND_TUNE_MODE:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-set-frontend.rst b/Documentation/userspace-api/media/dvb/fe-set-frontend.rst
index 960c95cb18a0..2b169778e0d6 100644
--- a/Documentation/userspace-api/media/dvb/fe-set-frontend.rst
+++ b/Documentation/userspace-api/media/dvb/fe-set-frontend.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _FE_SET_FRONTEND:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-set-tone.rst b/Documentation/userspace-api/media/dvb/fe-set-tone.rst
index 5726a20c7991..944d54488e71 100644
--- a/Documentation/userspace-api/media/dvb/fe-set-tone.rst
+++ b/Documentation/userspace-api/media/dvb/fe-set-tone.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _FE_SET_TONE:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-set-voltage.rst b/Documentation/userspace-api/media/dvb/fe-set-voltage.rst
index f3191808f4fd..73740be0e7dc 100644
--- a/Documentation/userspace-api/media/dvb/fe-set-voltage.rst
+++ b/Documentation/userspace-api/media/dvb/fe-set-voltage.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _FE_SET_VOLTAGE:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-type-t.rst b/Documentation/userspace-api/media/dvb/fe-type-t.rst
index 1617a8cc9045..e8499d482700 100644
--- a/Documentation/userspace-api/media/dvb/fe-type-t.rst
+++ b/Documentation/userspace-api/media/dvb/fe-type-t.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 *************
 Frontend type
diff --git a/Documentation/userspace-api/media/dvb/fe_property_parameters.rst b/Documentation/userspace-api/media/dvb/fe_property_parameters.rst
index 3f4ced2800e3..ecd84a8790a2 100644
--- a/Documentation/userspace-api/media/dvb/fe_property_parameters.rst
+++ b/Documentation/userspace-api/media/dvb/fe_property_parameters.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _fe_property_parameters:
 
diff --git a/Documentation/userspace-api/media/dvb/frontend-header.rst b/Documentation/userspace-api/media/dvb/frontend-header.rst
index cf8e515e5e1f..77f403361432 100644
--- a/Documentation/userspace-api/media/dvb/frontend-header.rst
+++ b/Documentation/userspace-api/media/dvb/frontend-header.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 Frontend uAPI data types
 ========================
diff --git a/Documentation/userspace-api/media/dvb/frontend-property-cable-systems.rst b/Documentation/userspace-api/media/dvb/frontend-property-cable-systems.rst
index 56657a6ec6ff..92ef98964140 100644
--- a/Documentation/userspace-api/media/dvb/frontend-property-cable-systems.rst
+++ b/Documentation/userspace-api/media/dvb/frontend-property-cable-systems.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _frontend-property-cable-systems:
 
diff --git a/Documentation/userspace-api/media/dvb/frontend-property-satellite-systems.rst b/Documentation/userspace-api/media/dvb/frontend-property-satellite-systems.rst
index e64fd625c476..13b344b286b3 100644
--- a/Documentation/userspace-api/media/dvb/frontend-property-satellite-systems.rst
+++ b/Documentation/userspace-api/media/dvb/frontend-property-satellite-systems.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _frontend-property-satellite-systems:
 
diff --git a/Documentation/userspace-api/media/dvb/frontend-property-terrestrial-systems.rst b/Documentation/userspace-api/media/dvb/frontend-property-terrestrial-systems.rst
index 1079522b2425..8cd461ceeea7 100644
--- a/Documentation/userspace-api/media/dvb/frontend-property-terrestrial-systems.rst
+++ b/Documentation/userspace-api/media/dvb/frontend-property-terrestrial-systems.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _frontend-property-terrestrial-systems:
 
diff --git a/Documentation/userspace-api/media/dvb/frontend-stat-properties.rst b/Documentation/userspace-api/media/dvb/frontend-stat-properties.rst
index ae6ed5128deb..223c1c56c9d3 100644
--- a/Documentation/userspace-api/media/dvb/frontend-stat-properties.rst
+++ b/Documentation/userspace-api/media/dvb/frontend-stat-properties.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _frontend-stat-properties:
 
diff --git a/Documentation/userspace-api/media/dvb/frontend.rst b/Documentation/userspace-api/media/dvb/frontend.rst
index 41ad519ca502..1df68730f181 100644
--- a/Documentation/userspace-api/media/dvb/frontend.rst
+++ b/Documentation/userspace-api/media/dvb/frontend.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _dvb_frontend:
 
diff --git a/Documentation/userspace-api/media/dvb/frontend_f_close.rst b/Documentation/userspace-api/media/dvb/frontend_f_close.rst
index 582e19a83c1a..96e15b4ee76d 100644
--- a/Documentation/userspace-api/media/dvb/frontend_f_close.rst
+++ b/Documentation/userspace-api/media/dvb/frontend_f_close.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _frontend_f_close:
 
diff --git a/Documentation/userspace-api/media/dvb/frontend_f_open.rst b/Documentation/userspace-api/media/dvb/frontend_f_open.rst
index 0be3b249d33b..49a01dd58d03 100644
--- a/Documentation/userspace-api/media/dvb/frontend_f_open.rst
+++ b/Documentation/userspace-api/media/dvb/frontend_f_open.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _frontend_f_open:
 
diff --git a/Documentation/userspace-api/media/dvb/frontend_fcalls.rst b/Documentation/userspace-api/media/dvb/frontend_fcalls.rst
index 2b5e7a4dba9e..1df27b6e84f9 100644
--- a/Documentation/userspace-api/media/dvb/frontend_fcalls.rst
+++ b/Documentation/userspace-api/media/dvb/frontend_fcalls.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _frontend_fcalls:
 
diff --git a/Documentation/userspace-api/media/dvb/frontend_legacy_api.rst b/Documentation/userspace-api/media/dvb/frontend_legacy_api.rst
index 1bd804f9b364..535828c002d6 100644
--- a/Documentation/userspace-api/media/dvb/frontend_legacy_api.rst
+++ b/Documentation/userspace-api/media/dvb/frontend_legacy_api.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _frontend_legacy_types:
 
diff --git a/Documentation/userspace-api/media/dvb/frontend_legacy_dvbv3_api.rst b/Documentation/userspace-api/media/dvb/frontend_legacy_dvbv3_api.rst
index 29ad0f9b90a4..09de723c2c27 100644
--- a/Documentation/userspace-api/media/dvb/frontend_legacy_dvbv3_api.rst
+++ b/Documentation/userspace-api/media/dvb/frontend_legacy_dvbv3_api.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _frontend_legacy_dvbv3_api:
 
diff --git a/Documentation/userspace-api/media/dvb/headers.rst b/Documentation/userspace-api/media/dvb/headers.rst
index ffd8f432484a..9743ffc35096 100644
--- a/Documentation/userspace-api/media/dvb/headers.rst
+++ b/Documentation/userspace-api/media/dvb/headers.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 ****************************
 Digital TV uAPI header files
diff --git a/Documentation/userspace-api/media/dvb/intro.rst b/Documentation/userspace-api/media/dvb/intro.rst
index f1235ef4599e..a935f3914e56 100644
--- a/Documentation/userspace-api/media/dvb/intro.rst
+++ b/Documentation/userspace-api/media/dvb/intro.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _dvb_introdution:
 
diff --git a/Documentation/userspace-api/media/dvb/legacy_dvb_apis.rst b/Documentation/userspace-api/media/dvb/legacy_dvb_apis.rst
index 17c3b062afb3..6104879d728a 100644
--- a/Documentation/userspace-api/media/dvb/legacy_dvb_apis.rst
+++ b/Documentation/userspace-api/media/dvb/legacy_dvb_apis.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _legacy_dvb_apis:
 
diff --git a/Documentation/userspace-api/media/dvb/net-add-if.rst b/Documentation/userspace-api/media/dvb/net-add-if.rst
index e75ec4d80a08..0859830b645e 100644
--- a/Documentation/userspace-api/media/dvb/net-add-if.rst
+++ b/Documentation/userspace-api/media/dvb/net-add-if.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _NET_ADD_IF:
 
diff --git a/Documentation/userspace-api/media/dvb/net-get-if.rst b/Documentation/userspace-api/media/dvb/net-get-if.rst
index c5421d9a8c0b..d8c9f939d62c 100644
--- a/Documentation/userspace-api/media/dvb/net-get-if.rst
+++ b/Documentation/userspace-api/media/dvb/net-get-if.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _NET_GET_IF:
 
diff --git a/Documentation/userspace-api/media/dvb/net-remove-if.rst b/Documentation/userspace-api/media/dvb/net-remove-if.rst
index d530559f66f1..ecbcacbaf9f7 100644
--- a/Documentation/userspace-api/media/dvb/net-remove-if.rst
+++ b/Documentation/userspace-api/media/dvb/net-remove-if.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _NET_REMOVE_IF:
 
diff --git a/Documentation/userspace-api/media/dvb/net-types.rst b/Documentation/userspace-api/media/dvb/net-types.rst
index 94323cffe8af..075264bc0394 100644
--- a/Documentation/userspace-api/media/dvb/net-types.rst
+++ b/Documentation/userspace-api/media/dvb/net-types.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _net_types:
 
diff --git a/Documentation/userspace-api/media/dvb/net.rst b/Documentation/userspace-api/media/dvb/net.rst
index 084f33d1ba28..33368f5150c5 100644
--- a/Documentation/userspace-api/media/dvb/net.rst
+++ b/Documentation/userspace-api/media/dvb/net.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _net:
 
diff --git a/Documentation/userspace-api/media/dvb/query-dvb-frontend-info.rst b/Documentation/userspace-api/media/dvb/query-dvb-frontend-info.rst
index d854ccf42ccf..f099b49357ed 100644
--- a/Documentation/userspace-api/media/dvb/query-dvb-frontend-info.rst
+++ b/Documentation/userspace-api/media/dvb/query-dvb-frontend-info.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _query-dvb-frontend-info:
 
diff --git a/Documentation/userspace-api/media/dvb/video-clear-buffer.rst b/Documentation/userspace-api/media/dvb/video-clear-buffer.rst
index ba7a13302862..fa1f2f49bdac 100644
--- a/Documentation/userspace-api/media/dvb/video-clear-buffer.rst
+++ b/Documentation/userspace-api/media/dvb/video-clear-buffer.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_CLEAR_BUFFER:
 
diff --git a/Documentation/userspace-api/media/dvb/video-command.rst b/Documentation/userspace-api/media/dvb/video-command.rst
index d96d764d0eef..ef0da85d5f92 100644
--- a/Documentation/userspace-api/media/dvb/video-command.rst
+++ b/Documentation/userspace-api/media/dvb/video-command.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_COMMAND:
 
diff --git a/Documentation/userspace-api/media/dvb/video-continue.rst b/Documentation/userspace-api/media/dvb/video-continue.rst
index bb18514ac5e9..9a767b50b23b 100644
--- a/Documentation/userspace-api/media/dvb/video-continue.rst
+++ b/Documentation/userspace-api/media/dvb/video-continue.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_CONTINUE:
 
diff --git a/Documentation/userspace-api/media/dvb/video-fast-forward.rst b/Documentation/userspace-api/media/dvb/video-fast-forward.rst
index 1f6ec89574d1..c43a13c7ae75 100644
--- a/Documentation/userspace-api/media/dvb/video-fast-forward.rst
+++ b/Documentation/userspace-api/media/dvb/video-fast-forward.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_FAST_FORWARD:
 
diff --git a/Documentation/userspace-api/media/dvb/video-fclose.rst b/Documentation/userspace-api/media/dvb/video-fclose.rst
index f9d2a8ebe4a4..27ccb2d6f961 100644
--- a/Documentation/userspace-api/media/dvb/video-fclose.rst
+++ b/Documentation/userspace-api/media/dvb/video-fclose.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _video_fclose:
 
diff --git a/Documentation/userspace-api/media/dvb/video-fopen.rst b/Documentation/userspace-api/media/dvb/video-fopen.rst
index a418cf6d772e..aa1dc6020fa7 100644
--- a/Documentation/userspace-api/media/dvb/video-fopen.rst
+++ b/Documentation/userspace-api/media/dvb/video-fopen.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _video_fopen:
 
diff --git a/Documentation/userspace-api/media/dvb/video-freeze.rst b/Documentation/userspace-api/media/dvb/video-freeze.rst
index 46f287faa7fe..93e0ae8e79d8 100644
--- a/Documentation/userspace-api/media/dvb/video-freeze.rst
+++ b/Documentation/userspace-api/media/dvb/video-freeze.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_FREEZE:
 
diff --git a/Documentation/userspace-api/media/dvb/video-fwrite.rst b/Documentation/userspace-api/media/dvb/video-fwrite.rst
index 08dfafa9c6a1..5ccdf78f11e1 100644
--- a/Documentation/userspace-api/media/dvb/video-fwrite.rst
+++ b/Documentation/userspace-api/media/dvb/video-fwrite.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _video_fwrite:
 
diff --git a/Documentation/userspace-api/media/dvb/video-get-capabilities.rst b/Documentation/userspace-api/media/dvb/video-get-capabilities.rst
index f6f19df5a3b4..619f78a66b6c 100644
--- a/Documentation/userspace-api/media/dvb/video-get-capabilities.rst
+++ b/Documentation/userspace-api/media/dvb/video-get-capabilities.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_GET_CAPABILITIES:
 
diff --git a/Documentation/userspace-api/media/dvb/video-get-event.rst b/Documentation/userspace-api/media/dvb/video-get-event.rst
index 6db8e6337c4f..29566a245fcd 100644
--- a/Documentation/userspace-api/media/dvb/video-get-event.rst
+++ b/Documentation/userspace-api/media/dvb/video-get-event.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_GET_EVENT:
 
diff --git a/Documentation/userspace-api/media/dvb/video-get-frame-count.rst b/Documentation/userspace-api/media/dvb/video-get-frame-count.rst
index 4152a42daeb3..5f65f8dba184 100644
--- a/Documentation/userspace-api/media/dvb/video-get-frame-count.rst
+++ b/Documentation/userspace-api/media/dvb/video-get-frame-count.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_GET_FRAME_COUNT:
 
diff --git a/Documentation/userspace-api/media/dvb/video-get-pts.rst b/Documentation/userspace-api/media/dvb/video-get-pts.rst
index f957df792ae1..28655a1a9249 100644
--- a/Documentation/userspace-api/media/dvb/video-get-pts.rst
+++ b/Documentation/userspace-api/media/dvb/video-get-pts.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_GET_PTS:
 
diff --git a/Documentation/userspace-api/media/dvb/video-get-size.rst b/Documentation/userspace-api/media/dvb/video-get-size.rst
index 376745550eb5..a199afbfc1b1 100644
--- a/Documentation/userspace-api/media/dvb/video-get-size.rst
+++ b/Documentation/userspace-api/media/dvb/video-get-size.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_GET_SIZE:
 
diff --git a/Documentation/userspace-api/media/dvb/video-get-status.rst b/Documentation/userspace-api/media/dvb/video-get-status.rst
index d0172593e557..3f29dac18a21 100644
--- a/Documentation/userspace-api/media/dvb/video-get-status.rst
+++ b/Documentation/userspace-api/media/dvb/video-get-status.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_GET_STATUS:
 
diff --git a/Documentation/userspace-api/media/dvb/video-play.rst b/Documentation/userspace-api/media/dvb/video-play.rst
index 2b6b4e93bd93..71db54d840cb 100644
--- a/Documentation/userspace-api/media/dvb/video-play.rst
+++ b/Documentation/userspace-api/media/dvb/video-play.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_PLAY:
 
diff --git a/Documentation/userspace-api/media/dvb/video-select-source.rst b/Documentation/userspace-api/media/dvb/video-select-source.rst
index 504f768da00c..2e4ee53fa155 100644
--- a/Documentation/userspace-api/media/dvb/video-select-source.rst
+++ b/Documentation/userspace-api/media/dvb/video-select-source.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_SELECT_SOURCE:
 
diff --git a/Documentation/userspace-api/media/dvb/video-set-blank.rst b/Documentation/userspace-api/media/dvb/video-set-blank.rst
index a2608df94d3e..5454fe7905bd 100644
--- a/Documentation/userspace-api/media/dvb/video-set-blank.rst
+++ b/Documentation/userspace-api/media/dvb/video-set-blank.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_SET_BLANK:
 
diff --git a/Documentation/userspace-api/media/dvb/video-set-display-format.rst b/Documentation/userspace-api/media/dvb/video-set-display-format.rst
index c587b3d15e30..ada6113e2f2d 100644
--- a/Documentation/userspace-api/media/dvb/video-set-display-format.rst
+++ b/Documentation/userspace-api/media/dvb/video-set-display-format.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_SET_DISPLAY_FORMAT:
 
diff --git a/Documentation/userspace-api/media/dvb/video-set-format.rst b/Documentation/userspace-api/media/dvb/video-set-format.rst
index ced74edb74eb..758a5d1642ab 100644
--- a/Documentation/userspace-api/media/dvb/video-set-format.rst
+++ b/Documentation/userspace-api/media/dvb/video-set-format.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_SET_FORMAT:
 
diff --git a/Documentation/userspace-api/media/dvb/video-set-streamtype.rst b/Documentation/userspace-api/media/dvb/video-set-streamtype.rst
index 1729bc04e4f7..f3a99858b1db 100644
--- a/Documentation/userspace-api/media/dvb/video-set-streamtype.rst
+++ b/Documentation/userspace-api/media/dvb/video-set-streamtype.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_SET_STREAMTYPE:
 
diff --git a/Documentation/userspace-api/media/dvb/video-slowmotion.rst b/Documentation/userspace-api/media/dvb/video-slowmotion.rst
index b8cfba7bbfb3..2ccb84d6a68b 100644
--- a/Documentation/userspace-api/media/dvb/video-slowmotion.rst
+++ b/Documentation/userspace-api/media/dvb/video-slowmotion.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_SLOWMOTION:
 
diff --git a/Documentation/userspace-api/media/dvb/video-stillpicture.rst b/Documentation/userspace-api/media/dvb/video-stillpicture.rst
index 5432619a63a1..a04f9f3ed162 100644
--- a/Documentation/userspace-api/media/dvb/video-stillpicture.rst
+++ b/Documentation/userspace-api/media/dvb/video-stillpicture.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_STILLPICTURE:
 
diff --git a/Documentation/userspace-api/media/dvb/video-stop.rst b/Documentation/userspace-api/media/dvb/video-stop.rst
index 9a53fe7f2fd0..9318655dce23 100644
--- a/Documentation/userspace-api/media/dvb/video-stop.rst
+++ b/Documentation/userspace-api/media/dvb/video-stop.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_STOP:
 
diff --git a/Documentation/userspace-api/media/dvb/video-try-command.rst b/Documentation/userspace-api/media/dvb/video-try-command.rst
index 61667952030f..430c36035329 100644
--- a/Documentation/userspace-api/media/dvb/video-try-command.rst
+++ b/Documentation/userspace-api/media/dvb/video-try-command.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDEO_TRY_COMMAND:
 
diff --git a/Documentation/userspace-api/media/dvb/video.rst b/Documentation/userspace-api/media/dvb/video.rst
index 537eae1b0723..3ed1bbfb93c3 100644
--- a/Documentation/userspace-api/media/dvb/video.rst
+++ b/Documentation/userspace-api/media/dvb/video.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _dvb_video:
 
diff --git a/Documentation/userspace-api/media/dvb/video_function_calls.rst b/Documentation/userspace-api/media/dvb/video_function_calls.rst
index 4902a40d65ba..20a897be5dca 100644
--- a/Documentation/userspace-api/media/dvb/video_function_calls.rst
+++ b/Documentation/userspace-api/media/dvb/video_function_calls.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _video_function_calls:
 
diff --git a/Documentation/userspace-api/media/dvb/video_types.rst b/Documentation/userspace-api/media/dvb/video_types.rst
index bdba1d48f647..c4557d328b7a 100644
--- a/Documentation/userspace-api/media/dvb/video_types.rst
+++ b/Documentation/userspace-api/media/dvb/video_types.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _video_types:
 
diff --git a/Documentation/userspace-api/media/fdl-appendix.rst b/Documentation/userspace-api/media/fdl-appendix.rst
index 70c8cda10814..683ebed87017 100644
--- a/Documentation/userspace-api/media/fdl-appendix.rst
+++ b/Documentation/userspace-api/media/fdl-appendix.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _fdl:
 
diff --git a/Documentation/userspace-api/media/gen-errors.rst b/Documentation/userspace-api/media/gen-errors.rst
index abae4dbed549..e595d0bea109 100644
--- a/Documentation/userspace-api/media/gen-errors.rst
+++ b/Documentation/userspace-api/media/gen-errors.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _gen_errors:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-controller-intro.rst b/Documentation/userspace-api/media/mediactl/media-controller-intro.rst
index 1d06ea4c4d09..fce7eafc37c4 100644
--- a/Documentation/userspace-api/media/mediactl/media-controller-intro.rst
+++ b/Documentation/userspace-api/media/mediactl/media-controller-intro.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _media-controller-intro:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-controller-model.rst b/Documentation/userspace-api/media/mediactl/media-controller-model.rst
index 865e73d934d6..222cb99debb5 100644
--- a/Documentation/userspace-api/media/mediactl/media-controller-model.rst
+++ b/Documentation/userspace-api/media/mediactl/media-controller-model.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _media-controller-model:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-controller.rst b/Documentation/userspace-api/media/mediactl/media-controller.rst
index 16bc3ab180d3..508dd693bf6c 100644
--- a/Documentation/userspace-api/media/mediactl/media-controller.rst
+++ b/Documentation/userspace-api/media/mediactl/media-controller.rst
@@ -1,12 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
-
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 .. include:: <isonum.txt>
 
 .. _media_controller:
diff --git a/Documentation/userspace-api/media/mediactl/media-func-close.rst b/Documentation/userspace-api/media/mediactl/media-func-close.rst
index ceec61c9e7c5..ec571b34ce69 100644
--- a/Documentation/userspace-api/media/mediactl/media-func-close.rst
+++ b/Documentation/userspace-api/media/mediactl/media-func-close.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _media-func-close:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-func-ioctl.rst b/Documentation/userspace-api/media/mediactl/media-func-ioctl.rst
index 629e7be7c5be..35ed549bec0e 100644
--- a/Documentation/userspace-api/media/mediactl/media-func-ioctl.rst
+++ b/Documentation/userspace-api/media/mediactl/media-func-ioctl.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _media-func-ioctl:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-func-open.rst b/Documentation/userspace-api/media/mediactl/media-func-open.rst
index 4ade1cc5048f..2c2595157ea3 100644
--- a/Documentation/userspace-api/media/mediactl/media-func-open.rst
+++ b/Documentation/userspace-api/media/mediactl/media-func-open.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _media-func-open:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-funcs.rst b/Documentation/userspace-api/media/mediactl/media-funcs.rst
index 085e80e7fbd5..e896296812c1 100644
--- a/Documentation/userspace-api/media/mediactl/media-funcs.rst
+++ b/Documentation/userspace-api/media/mediactl/media-funcs.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _media-user-func:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-header.rst b/Documentation/userspace-api/media/mediactl/media-header.rst
index 7ff9d24ce65f..c674271c93f5 100644
--- a/Documentation/userspace-api/media/mediactl/media-header.rst
+++ b/Documentation/userspace-api/media/mediactl/media-header.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _media_header:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-ioc-device-info.rst b/Documentation/userspace-api/media/mediactl/media-ioc-device-info.rst
index 9c729bdc8e85..cde1ddfc0bfb 100644
--- a/Documentation/userspace-api/media/mediactl/media-ioc-device-info.rst
+++ b/Documentation/userspace-api/media/mediactl/media-ioc-device-info.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _media_ioc_device_info:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-ioc-enum-entities.rst b/Documentation/userspace-api/media/mediactl/media-ioc-enum-entities.rst
index 1d01de8e0f97..93e35f198f47 100644
--- a/Documentation/userspace-api/media/mediactl/media-ioc-enum-entities.rst
+++ b/Documentation/userspace-api/media/mediactl/media-ioc-enum-entities.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _media_ioc_enum_entities:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-ioc-enum-links.rst b/Documentation/userspace-api/media/mediactl/media-ioc-enum-links.rst
index 9929b639db97..f3e94c7b5dc3 100644
--- a/Documentation/userspace-api/media/mediactl/media-ioc-enum-links.rst
+++ b/Documentation/userspace-api/media/mediactl/media-ioc-enum-links.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _media_ioc_enum_links:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-ioc-g-topology.rst b/Documentation/userspace-api/media/mediactl/media-ioc-g-topology.rst
index 54e3112a3b5a..9b7d2296b7fd 100644
--- a/Documentation/userspace-api/media/mediactl/media-ioc-g-topology.rst
+++ b/Documentation/userspace-api/media/mediactl/media-ioc-g-topology.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _media_ioc_g_topology:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-ioc-setup-link.rst b/Documentation/userspace-api/media/mediactl/media-ioc-setup-link.rst
index 7da3d0028285..e2aa51015783 100644
--- a/Documentation/userspace-api/media/mediactl/media-ioc-setup-link.rst
+++ b/Documentation/userspace-api/media/mediactl/media-ioc-setup-link.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _media_ioc_setup_link:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-types.rst b/Documentation/userspace-api/media/mediactl/media-types.rst
index 77fd4c0c9ebc..7b24a213cae7 100644
--- a/Documentation/userspace-api/media/mediactl/media-types.rst
+++ b/Documentation/userspace-api/media/mediactl/media-types.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _media-controller-types:
 
diff --git a/Documentation/userspace-api/media/rc/keytable.c.rst b/Documentation/userspace-api/media/rc/keytable.c.rst
index 901d33d37843..0b50cfaf2d86 100644
--- a/Documentation/userspace-api/media/rc/keytable.c.rst
+++ b/Documentation/userspace-api/media/rc/keytable.c.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 file: uapi/v4l/keytable.c
 =========================
diff --git a/Documentation/userspace-api/media/rc/lirc-dev-intro.rst b/Documentation/userspace-api/media/rc/lirc-dev-intro.rst
index 0c3d70ded55d..167b354bf051 100644
--- a/Documentation/userspace-api/media/rc/lirc-dev-intro.rst
+++ b/Documentation/userspace-api/media/rc/lirc-dev-intro.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _lirc_dev_intro:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-dev.rst b/Documentation/userspace-api/media/rc/lirc-dev.rst
index 7a395fa52934..5510dc02a822 100644
--- a/Documentation/userspace-api/media/rc/lirc-dev.rst
+++ b/Documentation/userspace-api/media/rc/lirc-dev.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _lirc_dev:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-func.rst b/Documentation/userspace-api/media/rc/lirc-func.rst
index e37c99583212..420a3dbf0d6b 100644
--- a/Documentation/userspace-api/media/rc/lirc-func.rst
+++ b/Documentation/userspace-api/media/rc/lirc-func.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _lirc_func:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-get-features.rst b/Documentation/userspace-api/media/rc/lirc-get-features.rst
index f4b9ca09f828..6846ae99848c 100644
--- a/Documentation/userspace-api/media/rc/lirc-get-features.rst
+++ b/Documentation/userspace-api/media/rc/lirc-get-features.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _lirc_get_features:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-get-rec-mode.rst b/Documentation/userspace-api/media/rc/lirc-get-rec-mode.rst
index 674ce16d5d33..e8f397a87331 100644
--- a/Documentation/userspace-api/media/rc/lirc-get-rec-mode.rst
+++ b/Documentation/userspace-api/media/rc/lirc-get-rec-mode.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _lirc_get_rec_mode:
 .. _lirc_set_rec_mode:
diff --git a/Documentation/userspace-api/media/rc/lirc-get-rec-resolution.rst b/Documentation/userspace-api/media/rc/lirc-get-rec-resolution.rst
index f20b5bf41232..3f08aa7c24a9 100644
--- a/Documentation/userspace-api/media/rc/lirc-get-rec-resolution.rst
+++ b/Documentation/userspace-api/media/rc/lirc-get-rec-resolution.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _lirc_get_rec_resolution:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-get-send-mode.rst b/Documentation/userspace-api/media/rc/lirc-get-send-mode.rst
index 973a47bf6068..f93b30c92193 100644
--- a/Documentation/userspace-api/media/rc/lirc-get-send-mode.rst
+++ b/Documentation/userspace-api/media/rc/lirc-get-send-mode.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _lirc_get_send_mode:
 .. _lirc_set_send_mode:
diff --git a/Documentation/userspace-api/media/rc/lirc-get-timeout.rst b/Documentation/userspace-api/media/rc/lirc-get-timeout.rst
index 5db84096d7f8..ec191a383d75 100644
--- a/Documentation/userspace-api/media/rc/lirc-get-timeout.rst
+++ b/Documentation/userspace-api/media/rc/lirc-get-timeout.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _lirc_get_min_timeout:
 .. _lirc_get_max_timeout:
diff --git a/Documentation/userspace-api/media/rc/lirc-header.rst b/Documentation/userspace-api/media/rc/lirc-header.rst
index c7e0716da159..8bd0acc9913a 100644
--- a/Documentation/userspace-api/media/rc/lirc-header.rst
+++ b/Documentation/userspace-api/media/rc/lirc-header.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _lirc_header:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-read.rst b/Documentation/userspace-api/media/rc/lirc-read.rst
index 13f7f5353851..b94a349bd99e 100644
--- a/Documentation/userspace-api/media/rc/lirc-read.rst
+++ b/Documentation/userspace-api/media/rc/lirc-read.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _lirc-read:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-set-measure-carrier-mode.rst b/Documentation/userspace-api/media/rc/lirc-set-measure-carrier-mode.rst
index 4cf9472eb904..820d6bf28c1c 100644
--- a/Documentation/userspace-api/media/rc/lirc-set-measure-carrier-mode.rst
+++ b/Documentation/userspace-api/media/rc/lirc-set-measure-carrier-mode.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _lirc_set_measure_carrier_mode:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-set-rec-carrier-range.rst b/Documentation/userspace-api/media/rc/lirc-set-rec-carrier-range.rst
index 0439e93aa267..e33e6a320b7a 100644
--- a/Documentation/userspace-api/media/rc/lirc-set-rec-carrier-range.rst
+++ b/Documentation/userspace-api/media/rc/lirc-set-rec-carrier-range.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _lirc_set_rec_carrier_range:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-set-rec-carrier.rst b/Documentation/userspace-api/media/rc/lirc-set-rec-carrier.rst
index f4d18897cb9f..a6784d5e59c8 100644
--- a/Documentation/userspace-api/media/rc/lirc-set-rec-carrier.rst
+++ b/Documentation/userspace-api/media/rc/lirc-set-rec-carrier.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _lirc_set_rec_carrier:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-set-rec-timeout-reports.rst b/Documentation/userspace-api/media/rc/lirc-set-rec-timeout-reports.rst
index ab97f87fa757..55be65df7d5a 100644
--- a/Documentation/userspace-api/media/rc/lirc-set-rec-timeout-reports.rst
+++ b/Documentation/userspace-api/media/rc/lirc-set-rec-timeout-reports.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _lirc_set_rec_timeout_reports:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-set-rec-timeout.rst b/Documentation/userspace-api/media/rc/lirc-set-rec-timeout.rst
index 227776cf7c62..e91a0daecde6 100644
--- a/Documentation/userspace-api/media/rc/lirc-set-rec-timeout.rst
+++ b/Documentation/userspace-api/media/rc/lirc-set-rec-timeout.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _lirc_set_rec_timeout:
 .. _lirc_get_rec_timeout:
diff --git a/Documentation/userspace-api/media/rc/lirc-set-send-carrier.rst b/Documentation/userspace-api/media/rc/lirc-set-send-carrier.rst
index 7eaf2b993207..e199aac7d8e0 100644
--- a/Documentation/userspace-api/media/rc/lirc-set-send-carrier.rst
+++ b/Documentation/userspace-api/media/rc/lirc-set-send-carrier.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _lirc_set_send_carrier:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-set-send-duty-cycle.rst b/Documentation/userspace-api/media/rc/lirc-set-send-duty-cycle.rst
index 0dee89364cde..a9074f4fb058 100644
--- a/Documentation/userspace-api/media/rc/lirc-set-send-duty-cycle.rst
+++ b/Documentation/userspace-api/media/rc/lirc-set-send-duty-cycle.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _lirc_set_send_duty_cycle:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-set-transmitter-mask.rst b/Documentation/userspace-api/media/rc/lirc-set-transmitter-mask.rst
index dcee4b71dcf6..1f5527427281 100644
--- a/Documentation/userspace-api/media/rc/lirc-set-transmitter-mask.rst
+++ b/Documentation/userspace-api/media/rc/lirc-set-transmitter-mask.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _lirc_set_transmitter_mask:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-set-wideband-receiver.rst b/Documentation/userspace-api/media/rc/lirc-set-wideband-receiver.rst
index 22f6fe43b7e7..2c43b620b3f3 100644
--- a/Documentation/userspace-api/media/rc/lirc-set-wideband-receiver.rst
+++ b/Documentation/userspace-api/media/rc/lirc-set-wideband-receiver.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _lirc_set_wideband_receiver:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-write.rst b/Documentation/userspace-api/media/rc/lirc-write.rst
index 96ca4a22062e..421de2cfa4ca 100644
--- a/Documentation/userspace-api/media/rc/lirc-write.rst
+++ b/Documentation/userspace-api/media/rc/lirc-write.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _lirc-write:
 
diff --git a/Documentation/userspace-api/media/rc/rc-intro.rst b/Documentation/userspace-api/media/rc/rc-intro.rst
index 14e85157bf23..1338478e2bd4 100644
--- a/Documentation/userspace-api/media/rc/rc-intro.rst
+++ b/Documentation/userspace-api/media/rc/rc-intro.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _Remote_controllers_Intro:
 
diff --git a/Documentation/userspace-api/media/rc/rc-protos.rst b/Documentation/userspace-api/media/rc/rc-protos.rst
index b250ebe301d5..2e290584a210 100644
--- a/Documentation/userspace-api/media/rc/rc-protos.rst
+++ b/Documentation/userspace-api/media/rc/rc-protos.rst
@@ -1,6 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _Remote_controllers_Protocols:
 
diff --git a/Documentation/userspace-api/media/rc/rc-sysfs-nodes.rst b/Documentation/userspace-api/media/rc/rc-sysfs-nodes.rst
index 73dd75f77d65..43c442696438 100644
--- a/Documentation/userspace-api/media/rc/rc-sysfs-nodes.rst
+++ b/Documentation/userspace-api/media/rc/rc-sysfs-nodes.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _remote_controllers_sysfs_nodes:
 
diff --git a/Documentation/userspace-api/media/rc/rc-table-change.rst b/Documentation/userspace-api/media/rc/rc-table-change.rst
index f5d00a20b939..61c77b080ae8 100644
--- a/Documentation/userspace-api/media/rc/rc-table-change.rst
+++ b/Documentation/userspace-api/media/rc/rc-table-change.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _Remote_controllers_table_change:
 
diff --git a/Documentation/userspace-api/media/rc/rc-tables.rst b/Documentation/userspace-api/media/rc/rc-tables.rst
index 33b724b17ff3..8dc11657fc23 100644
--- a/Documentation/userspace-api/media/rc/rc-tables.rst
+++ b/Documentation/userspace-api/media/rc/rc-tables.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _Remote_controllers_tables:
 
diff --git a/Documentation/userspace-api/media/rc/remote_controllers.rst b/Documentation/userspace-api/media/rc/remote_controllers.rst
index 3ab2d6db1564..2d9078accb35 100644
--- a/Documentation/userspace-api/media/rc/remote_controllers.rst
+++ b/Documentation/userspace-api/media/rc/remote_controllers.rst
@@ -1,12 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
-
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 .. include:: <isonum.txt>
 
 .. _remote_controllers:
diff --git a/Documentation/userspace-api/media/v4l/app-pri.rst b/Documentation/userspace-api/media/v4l/app-pri.rst
index 5018ede2706f..626a42f2e138 100644
--- a/Documentation/userspace-api/media/v4l/app-pri.rst
+++ b/Documentation/userspace-api/media/v4l/app-pri.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _app-pri:
 
diff --git a/Documentation/userspace-api/media/v4l/async.rst b/Documentation/userspace-api/media/v4l/async.rst
index 8bc4a726c95e..d6960ff5c382 100644
--- a/Documentation/userspace-api/media/v4l/async.rst
+++ b/Documentation/userspace-api/media/v4l/async.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _async:
 
diff --git a/Documentation/userspace-api/media/v4l/audio.rst b/Documentation/userspace-api/media/v4l/audio.rst
index d6bb85092e02..17f0b1c89908 100644
--- a/Documentation/userspace-api/media/v4l/audio.rst
+++ b/Documentation/userspace-api/media/v4l/audio.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _audio:
 
diff --git a/Documentation/userspace-api/media/v4l/biblio.rst b/Documentation/userspace-api/media/v4l/biblio.rst
index 3c9634173e82..7869b6f6ff72 100644
--- a/Documentation/userspace-api/media/v4l/biblio.rst
+++ b/Documentation/userspace-api/media/v4l/biblio.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 **********
 References
diff --git a/Documentation/userspace-api/media/v4l/buffer.rst b/Documentation/userspace-api/media/v4l/buffer.rst
index 57e752aaf414..177ed8b6ce62 100644
--- a/Documentation/userspace-api/media/v4l/buffer.rst
+++ b/Documentation/userspace-api/media/v4l/buffer.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _buffer:
 
diff --git a/Documentation/userspace-api/media/v4l/capture-example.rst b/Documentation/userspace-api/media/v4l/capture-example.rst
index 6aa67c5aff8f..25891320b7ad 100644
--- a/Documentation/userspace-api/media/v4l/capture-example.rst
+++ b/Documentation/userspace-api/media/v4l/capture-example.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _capture-example:
 
diff --git a/Documentation/userspace-api/media/v4l/capture.c.rst b/Documentation/userspace-api/media/v4l/capture.c.rst
index 30f7c816e858..ccbd52c3897f 100644
--- a/Documentation/userspace-api/media/v4l/capture.c.rst
+++ b/Documentation/userspace-api/media/v4l/capture.c.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 file: media/v4l/capture.c
 =========================
diff --git a/Documentation/userspace-api/media/v4l/colorspaces-defs.rst b/Documentation/userspace-api/media/v4l/colorspaces-defs.rst
index 01404e1f609a..c3e8385e456e 100644
--- a/Documentation/userspace-api/media/v4l/colorspaces-defs.rst
+++ b/Documentation/userspace-api/media/v4l/colorspaces-defs.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 ****************************
 Defining Colorspaces in V4L2
diff --git a/Documentation/userspace-api/media/v4l/colorspaces-details.rst b/Documentation/userspace-api/media/v4l/colorspaces-details.rst
index 300c5d2e7d0f..14508e67501d 100644
--- a/Documentation/userspace-api/media/v4l/colorspaces-details.rst
+++ b/Documentation/userspace-api/media/v4l/colorspaces-details.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 ********************************
 Detailed Colorspace Descriptions
diff --git a/Documentation/userspace-api/media/v4l/colorspaces.rst b/Documentation/userspace-api/media/v4l/colorspaces.rst
index 0846df9066c5..2aa0dda4fd01 100644
--- a/Documentation/userspace-api/media/v4l/colorspaces.rst
+++ b/Documentation/userspace-api/media/v4l/colorspaces.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _colorspaces:
 
diff --git a/Documentation/userspace-api/media/v4l/common-defs.rst b/Documentation/userspace-api/media/v4l/common-defs.rst
index 370a1e364a51..6ae42ac7ddb7 100644
--- a/Documentation/userspace-api/media/v4l/common-defs.rst
+++ b/Documentation/userspace-api/media/v4l/common-defs.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _common-defs:
 
diff --git a/Documentation/userspace-api/media/v4l/common.rst b/Documentation/userspace-api/media/v4l/common.rst
index 7d81c58a13cd..d84aeb703165 100644
--- a/Documentation/userspace-api/media/v4l/common.rst
+++ b/Documentation/userspace-api/media/v4l/common.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _common:
 
diff --git a/Documentation/userspace-api/media/v4l/compat.rst b/Documentation/userspace-api/media/v4l/compat.rst
index 055286b86e9b..b63b8392dec6 100644
--- a/Documentation/userspace-api/media/v4l/compat.rst
+++ b/Documentation/userspace-api/media/v4l/compat.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _compat:
 
diff --git a/Documentation/userspace-api/media/v4l/control.rst b/Documentation/userspace-api/media/v4l/control.rst
index 3e991c1f7a12..4e5652eb6126 100644
--- a/Documentation/userspace-api/media/v4l/control.rst
+++ b/Documentation/userspace-api/media/v4l/control.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _control:
 
diff --git a/Documentation/userspace-api/media/v4l/crop.rst b/Documentation/userspace-api/media/v4l/crop.rst
index cb7e2341aedf..3fe185e25ccf 100644
--- a/Documentation/userspace-api/media/v4l/crop.rst
+++ b/Documentation/userspace-api/media/v4l/crop.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _crop:
 
diff --git a/Documentation/userspace-api/media/v4l/depth-formats.rst b/Documentation/userspace-api/media/v4l/depth-formats.rst
index 6742486a83b5..b4f3fc229c85 100644
--- a/Documentation/userspace-api/media/v4l/depth-formats.rst
+++ b/Documentation/userspace-api/media/v4l/depth-formats.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _depth-formats:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-capture.rst b/Documentation/userspace-api/media/v4l/dev-capture.rst
index 44d3094093ab..5ea1ffe71fa6 100644
--- a/Documentation/userspace-api/media/v4l/dev-capture.rst
+++ b/Documentation/userspace-api/media/v4l/dev-capture.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _capture:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-event.rst b/Documentation/userspace-api/media/v4l/dev-event.rst
index d09034fd680a..f34f9cf6ce6c 100644
--- a/Documentation/userspace-api/media/v4l/dev-event.rst
+++ b/Documentation/userspace-api/media/v4l/dev-event.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _event:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-mem2mem.rst b/Documentation/userspace-api/media/v4l/dev-mem2mem.rst
index 40aff9c95267..d8db46886555 100644
--- a/Documentation/userspace-api/media/v4l/dev-mem2mem.rst
+++ b/Documentation/userspace-api/media/v4l/dev-mem2mem.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _mem2mem:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-meta.rst b/Documentation/userspace-api/media/v4l/dev-meta.rst
index 6d2c5a79b370..8ec3a73dcae4 100644
--- a/Documentation/userspace-api/media/v4l/dev-meta.rst
+++ b/Documentation/userspace-api/media/v4l/dev-meta.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _metadata:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-osd.rst b/Documentation/userspace-api/media/v4l/dev-osd.rst
index ad0c156c7898..8e4be9129e75 100644
--- a/Documentation/userspace-api/media/v4l/dev-osd.rst
+++ b/Documentation/userspace-api/media/v4l/dev-osd.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _osd:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-output.rst b/Documentation/userspace-api/media/v4l/dev-output.rst
index e4f2a1d8b0fc..2315faf61aaf 100644
--- a/Documentation/userspace-api/media/v4l/dev-output.rst
+++ b/Documentation/userspace-api/media/v4l/dev-output.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _output:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-overlay.rst b/Documentation/userspace-api/media/v4l/dev-overlay.rst
index 7246d560173d..07cc92564c16 100644
--- a/Documentation/userspace-api/media/v4l/dev-overlay.rst
+++ b/Documentation/userspace-api/media/v4l/dev-overlay.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _overlay:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-radio.rst b/Documentation/userspace-api/media/v4l/dev-radio.rst
index c0edd7b7d201..284ce96a1637 100644
--- a/Documentation/userspace-api/media/v4l/dev-radio.rst
+++ b/Documentation/userspace-api/media/v4l/dev-radio.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _radio:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-raw-vbi.rst b/Documentation/userspace-api/media/v4l/dev-raw-vbi.rst
index 0307d44e17cb..bb52f85a619c 100644
--- a/Documentation/userspace-api/media/v4l/dev-raw-vbi.rst
+++ b/Documentation/userspace-api/media/v4l/dev-raw-vbi.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _raw-vbi:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-rds.rst b/Documentation/userspace-api/media/v4l/dev-rds.rst
index 13dba4a4180c..463726ba46d7 100644
--- a/Documentation/userspace-api/media/v4l/dev-rds.rst
+++ b/Documentation/userspace-api/media/v4l/dev-rds.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _rds:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-sdr.rst b/Documentation/userspace-api/media/v4l/dev-sdr.rst
index 4a80319a53c6..80b25a7e8017 100644
--- a/Documentation/userspace-api/media/v4l/dev-sdr.rst
+++ b/Documentation/userspace-api/media/v4l/dev-sdr.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _sdr:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-sliced-vbi.rst b/Documentation/userspace-api/media/v4l/dev-sliced-vbi.rst
index dd0b6646beb5..344166500706 100644
--- a/Documentation/userspace-api/media/v4l/dev-sliced-vbi.rst
+++ b/Documentation/userspace-api/media/v4l/dev-sliced-vbi.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _sliced:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-subdev.rst b/Documentation/userspace-api/media/v4l/dev-subdev.rst
index 134d2fb909fa..2aa8157efae1 100644
--- a/Documentation/userspace-api/media/v4l/dev-subdev.rst
+++ b/Documentation/userspace-api/media/v4l/dev-subdev.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _subdev:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-touch.rst b/Documentation/userspace-api/media/v4l/dev-touch.rst
index c1ce446274f2..a71b9def5d58 100644
--- a/Documentation/userspace-api/media/v4l/dev-touch.rst
+++ b/Documentation/userspace-api/media/v4l/dev-touch.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _touch:
 
diff --git a/Documentation/userspace-api/media/v4l/devices.rst b/Documentation/userspace-api/media/v4l/devices.rst
index 47ffe90753dd..8bfbad65a9d4 100644
--- a/Documentation/userspace-api/media/v4l/devices.rst
+++ b/Documentation/userspace-api/media/v4l/devices.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _devices:
 
diff --git a/Documentation/userspace-api/media/v4l/diff-v4l.rst b/Documentation/userspace-api/media/v4l/diff-v4l.rst
index 37644d26c4ae..3f7bac44377c 100644
--- a/Documentation/userspace-api/media/v4l/diff-v4l.rst
+++ b/Documentation/userspace-api/media/v4l/diff-v4l.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _diff-v4l:
 
diff --git a/Documentation/userspace-api/media/v4l/dmabuf.rst b/Documentation/userspace-api/media/v4l/dmabuf.rst
index 342421ff9497..f43d400dafaa 100644
--- a/Documentation/userspace-api/media/v4l/dmabuf.rst
+++ b/Documentation/userspace-api/media/v4l/dmabuf.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _dmabuf:
 
diff --git a/Documentation/userspace-api/media/v4l/dv-timings.rst b/Documentation/userspace-api/media/v4l/dv-timings.rst
index e216aa9edef0..e17f056b129f 100644
--- a/Documentation/userspace-api/media/v4l/dv-timings.rst
+++ b/Documentation/userspace-api/media/v4l/dv-timings.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _dv-timings:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
index d9a117f75c9c..c05a2d2c675d 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _camera-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index d0d506a444b1..0b797dba09b7 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _mpeg-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-detect.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-detect.rst
index 77a4992f26bd..312c4fa94dc3 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-detect.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-detect.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _detect-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-dv.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-dv.rst
index c572b65dc772..a6f696bf89dd 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-dv.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-dv.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _dv-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-flash.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-flash.rst
index 5053a380f7de..ad4b878cd034 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-flash.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-flash.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _flash-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-fm-rx.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-fm-rx.rst
index 69197bbe23dd..b6cfc0e823d2 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-fm-rx.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-fm-rx.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _fm-rx-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-fm-tx.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-fm-tx.rst
index c13ec0a6af3a..04c997c9a4c3 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-fm-tx.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-fm-tx.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _fm-tx-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-image-process.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-image-process.rst
index bb9d484c25e4..87698c15c027 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-image-process.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-image-process.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _image-process-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst
index 7b75158aca4d..9457dc340c31 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _image-source-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-jpeg.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-jpeg.rst
index 5ea69978f3ea..e07a2dbcd65d 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-jpeg.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-jpeg.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _jpeg-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-rf-tuner.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-rf-tuner.rst
index 5277138fce67..8a6f9f0373ff 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-rf-tuner.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-rf-tuner.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _rf-tuner-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/extended-controls.rst b/Documentation/userspace-api/media/v4l/extended-controls.rst
index 9aa352ac5ea4..70301538d222 100644
--- a/Documentation/userspace-api/media/v4l/extended-controls.rst
+++ b/Documentation/userspace-api/media/v4l/extended-controls.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _extended-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/field-order.rst b/Documentation/userspace-api/media/v4l/field-order.rst
index 04e9a6932dc5..54548ea4308c 100644
--- a/Documentation/userspace-api/media/v4l/field-order.rst
+++ b/Documentation/userspace-api/media/v4l/field-order.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _field-order:
 
diff --git a/Documentation/userspace-api/media/v4l/format.rst b/Documentation/userspace-api/media/v4l/format.rst
index e47fc0505727..eaa6445f6160 100644
--- a/Documentation/userspace-api/media/v4l/format.rst
+++ b/Documentation/userspace-api/media/v4l/format.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _format:
 
diff --git a/Documentation/userspace-api/media/v4l/func-close.rst b/Documentation/userspace-api/media/v4l/func-close.rst
index 37a64dae56b0..c03ff3e62738 100644
--- a/Documentation/userspace-api/media/v4l/func-close.rst
+++ b/Documentation/userspace-api/media/v4l/func-close.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _func-close:
 
diff --git a/Documentation/userspace-api/media/v4l/func-ioctl.rst b/Documentation/userspace-api/media/v4l/func-ioctl.rst
index 4e69f303636b..8bde6b4f1cb5 100644
--- a/Documentation/userspace-api/media/v4l/func-ioctl.rst
+++ b/Documentation/userspace-api/media/v4l/func-ioctl.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _func-ioctl:
 
diff --git a/Documentation/userspace-api/media/v4l/func-mmap.rst b/Documentation/userspace-api/media/v4l/func-mmap.rst
index f9c77bdce434..b3a9cd862a7f 100644
--- a/Documentation/userspace-api/media/v4l/func-mmap.rst
+++ b/Documentation/userspace-api/media/v4l/func-mmap.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _func-mmap:
 
diff --git a/Documentation/userspace-api/media/v4l/func-munmap.rst b/Documentation/userspace-api/media/v4l/func-munmap.rst
index 18a9941b47ab..e8a27e43373a 100644
--- a/Documentation/userspace-api/media/v4l/func-munmap.rst
+++ b/Documentation/userspace-api/media/v4l/func-munmap.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _func-munmap:
 
diff --git a/Documentation/userspace-api/media/v4l/func-open.rst b/Documentation/userspace-api/media/v4l/func-open.rst
index 8bcdec8ab387..f3890d284918 100644
--- a/Documentation/userspace-api/media/v4l/func-open.rst
+++ b/Documentation/userspace-api/media/v4l/func-open.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _func-open:
 
diff --git a/Documentation/userspace-api/media/v4l/func-poll.rst b/Documentation/userspace-api/media/v4l/func-poll.rst
index 2c6704c1fab7..95cf9c6fedcd 100644
--- a/Documentation/userspace-api/media/v4l/func-poll.rst
+++ b/Documentation/userspace-api/media/v4l/func-poll.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _func-poll:
 
diff --git a/Documentation/userspace-api/media/v4l/func-read.rst b/Documentation/userspace-api/media/v4l/func-read.rst
index 1728aa5d8313..56b255c595e1 100644
--- a/Documentation/userspace-api/media/v4l/func-read.rst
+++ b/Documentation/userspace-api/media/v4l/func-read.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _func-read:
 
diff --git a/Documentation/userspace-api/media/v4l/func-select.rst b/Documentation/userspace-api/media/v4l/func-select.rst
index 6aca8a290c1f..6715d5efcc27 100644
--- a/Documentation/userspace-api/media/v4l/func-select.rst
+++ b/Documentation/userspace-api/media/v4l/func-select.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _func-select:
 
diff --git a/Documentation/userspace-api/media/v4l/func-write.rst b/Documentation/userspace-api/media/v4l/func-write.rst
index fb1955f70f0f..37683611df04 100644
--- a/Documentation/userspace-api/media/v4l/func-write.rst
+++ b/Documentation/userspace-api/media/v4l/func-write.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _func-write:
 
diff --git a/Documentation/userspace-api/media/v4l/hist-v4l2.rst b/Documentation/userspace-api/media/v4l/hist-v4l2.rst
index 6dcfe6046e33..8be82bdb1729 100644
--- a/Documentation/userspace-api/media/v4l/hist-v4l2.rst
+++ b/Documentation/userspace-api/media/v4l/hist-v4l2.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _hist-v4l2:
 
diff --git a/Documentation/userspace-api/media/v4l/hsv-formats.rst b/Documentation/userspace-api/media/v4l/hsv-formats.rst
index 4906f7e0d80d..d810c914b673 100644
--- a/Documentation/userspace-api/media/v4l/hsv-formats.rst
+++ b/Documentation/userspace-api/media/v4l/hsv-formats.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _hsv-formats:
 
diff --git a/Documentation/userspace-api/media/v4l/io.rst b/Documentation/userspace-api/media/v4l/io.rst
index de0e2f529268..9dc36b41dbf6 100644
--- a/Documentation/userspace-api/media/v4l/io.rst
+++ b/Documentation/userspace-api/media/v4l/io.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _io:
 
diff --git a/Documentation/userspace-api/media/v4l/libv4l-introduction.rst b/Documentation/userspace-api/media/v4l/libv4l-introduction.rst
index 95f3127b4749..e03280b35570 100644
--- a/Documentation/userspace-api/media/v4l/libv4l-introduction.rst
+++ b/Documentation/userspace-api/media/v4l/libv4l-introduction.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _libv4l-introduction:
 
diff --git a/Documentation/userspace-api/media/v4l/libv4l.rst b/Documentation/userspace-api/media/v4l/libv4l.rst
index 5ea2016cac65..f446dd2d01ac 100644
--- a/Documentation/userspace-api/media/v4l/libv4l.rst
+++ b/Documentation/userspace-api/media/v4l/libv4l.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _libv4l:
 
diff --git a/Documentation/userspace-api/media/v4l/meta-formats.rst b/Documentation/userspace-api/media/v4l/meta-formats.rst
index 7dcc4bacbb0c..d8f31653be1e 100644
--- a/Documentation/userspace-api/media/v4l/meta-formats.rst
+++ b/Documentation/userspace-api/media/v4l/meta-formats.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _meta-formats:
 
diff --git a/Documentation/userspace-api/media/v4l/mmap.rst b/Documentation/userspace-api/media/v4l/mmap.rst
index 9c44d05ebc3f..1cce31c6de79 100644
--- a/Documentation/userspace-api/media/v4l/mmap.rst
+++ b/Documentation/userspace-api/media/v4l/mmap.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _mmap:
 
diff --git a/Documentation/userspace-api/media/v4l/open.rst b/Documentation/userspace-api/media/v4l/open.rst
index 38046ef20141..8a12f4f25357 100644
--- a/Documentation/userspace-api/media/v4l/open.rst
+++ b/Documentation/userspace-api/media/v4l/open.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _open:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-bayer.rst b/Documentation/userspace-api/media/v4l/pixfmt-bayer.rst
index be9a8385ebc1..2500413e5f43 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-bayer.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-bayer.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _pixfmt-bayer:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
index 3828bb79225d..d585909bc4e2 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 ******************
 Compressed Formats
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-grey.rst b/Documentation/userspace-api/media/v4l/pixfmt-grey.rst
index 7b03db3393be..121365b03c57 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-grey.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-grey.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-GREY:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-indexed.rst b/Documentation/userspace-api/media/v4l/pixfmt-indexed.rst
index d0d46ed27260..5bd4a47c5854 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-indexed.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-indexed.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _pixfmt-indexed:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-intro.rst b/Documentation/userspace-api/media/v4l/pixfmt-intro.rst
index af870895f653..14239ee826bf 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-intro.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-intro.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 **********************
 Standard Image Formats
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-inzi.rst b/Documentation/userspace-api/media/v4l/pixfmt-inzi.rst
index f85cccb71741..3115c8f6a842 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-inzi.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-inzi.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-INZI:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-m420.rst b/Documentation/userspace-api/media/v4l/pixfmt-m420.rst
index 5180bbe16c6e..13cf36a8cd5c 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-m420.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-m420.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-M420:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst b/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
index 4eaf2f9086a9..4e437ba97a0e 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _v4l2-meta-fmt-d4xx:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-uvc.rst b/Documentation/userspace-api/media/v4l/pixfmt-meta-uvc.rst
index debc50285a25..784346d14bbd 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-meta-uvc.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-meta-uvc.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _v4l2-meta-fmt-uvc:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-vsp1-hgo.rst b/Documentation/userspace-api/media/v4l/pixfmt-meta-vsp1-hgo.rst
index b780e447dd4b..8d886feb180c 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-meta-vsp1-hgo.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-meta-vsp1-hgo.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _v4l2-meta-fmt-vsp1-hgo:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-vsp1-hgt.rst b/Documentation/userspace-api/media/v4l/pixfmt-meta-vsp1-hgt.rst
index e165320cc1ff..d8830ff605de 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-meta-vsp1-hgt.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-meta-vsp1-hgt.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _v4l2-meta-fmt-vsp1-hgt:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-nv12.rst b/Documentation/userspace-api/media/v4l/pixfmt-nv12.rst
index 19d47b38e02a..dd2f38129fe6 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-nv12.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-nv12.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-NV12:
 .. _V4L2-PIX-FMT-NV21:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-nv12m.rst b/Documentation/userspace-api/media/v4l/pixfmt-nv12m.rst
index 115ea603c13f..250f8b977605 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-nv12m.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-nv12m.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-NV12M:
 .. _v4l2-pix-fmt-nv12mt-16x16:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-nv12mt.rst b/Documentation/userspace-api/media/v4l/pixfmt-nv12mt.rst
index daac1c16d4f2..46f63d793ec5 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-nv12mt.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-nv12mt.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-NV12MT:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-nv16.rst b/Documentation/userspace-api/media/v4l/pixfmt-nv16.rst
index 977636fc98d6..22295fc0c359 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-nv16.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-nv16.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-NV16:
 .. _V4L2-PIX-FMT-NV61:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-nv16m.rst b/Documentation/userspace-api/media/v4l/pixfmt-nv16m.rst
index cf33942d942d..812bf2ccabf0 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-nv16m.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-nv16m.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-NV16M:
 .. _v4l2-pix-fmt-nv61m:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-nv24.rst b/Documentation/userspace-api/media/v4l/pixfmt-nv24.rst
index c6fb97bd0472..bf1b94062fc2 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-nv24.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-nv24.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-NV24:
 .. _V4L2-PIX-FMT-NV42:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-packed-hsv.rst b/Documentation/userspace-api/media/v4l/pixfmt-packed-hsv.rst
index b8c9b0225eea..dd89860f50e0 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-packed-hsv.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-packed-hsv.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _packed-hsv:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
index bbd4bd094deb..84262208dd1c 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _packed-yuv:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
index 59b9e7238f90..9427cb182fee 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _pixfmt-reserved:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst b/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
index 89cc2a37b285..9d827097c1d9 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _pixfmt-rgb:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-sdr-cs08.rst b/Documentation/userspace-api/media/v4l/pixfmt-sdr-cs08.rst
index 13f3908d162a..bd6ee6111de4 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-sdr-cs08.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-sdr-cs08.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _v4l2-sdr-fmt-cs8:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-sdr-cs14le.rst b/Documentation/userspace-api/media/v4l/pixfmt-sdr-cs14le.rst
index 41e5b990d499..ea21b288d357 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-sdr-cs14le.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-sdr-cs14le.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-SDR-FMT-CS14LE:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-sdr-cu08.rst b/Documentation/userspace-api/media/v4l/pixfmt-sdr-cu08.rst
index 1085b5ad8eb7..45fce09d85ff 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-sdr-cu08.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-sdr-cu08.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _v4l2-sdr-fmt-cu8:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-sdr-cu16le.rst b/Documentation/userspace-api/media/v4l/pixfmt-sdr-cu16le.rst
index 9772b30bda95..7f4242f8da6f 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-sdr-cu16le.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-sdr-cu16le.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-SDR-FMT-CU16LE:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu16be.rst b/Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu16be.rst
index 53a0a862f33a..a4d4b70ece63 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu16be.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu16be.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-SDR-FMT-PCU16BE:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu18be.rst b/Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu18be.rst
index 7f2d2545fb04..3db690bd683a 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu18be.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu18be.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-SDR-FMT-PCU18BE:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu20be.rst b/Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu20be.rst
index 9f3d67b4e94c..485343cdf150 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu20be.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu20be.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-SDR-FMT-PCU20BE:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-sdr-ru12le.rst b/Documentation/userspace-api/media/v4l/pixfmt-sdr-ru12le.rst
index c9cde8d425f7..2ad4706bfc7a 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-sdr-ru12le.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-sdr-ru12le.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-SDR-FMT-RU12LE:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb10-ipu3.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb10-ipu3.rst
index 5afa02a66698..15f1900cd914 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-srggb10-ipu3.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-srggb10-ipu3.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _v4l2-pix-fmt-ipu3-sbggr10:
 .. _v4l2-pix-fmt-ipu3-sgbrg10:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb10.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb10.rst
index 37cc1bb8241f..a66414ab4291 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-srggb10.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-srggb10.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-SRGGB10:
 .. _v4l2-pix-fmt-sbggr10:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb10alaw8.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb10alaw8.rst
index f1b8627f0141..a5ae1f099e68 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-srggb10alaw8.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-srggb10alaw8.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-SBGGR10ALAW8:
 .. _v4l2-pix-fmt-sgbrg10alaw8:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb10dpcm8.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb10dpcm8.rst
index 9814c4ffac68..f0544c6f4580 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-srggb10dpcm8.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-srggb10dpcm8.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-SBGGR10DPCM8:
 .. _v4l2-pix-fmt-sgbrg10dpcm8:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb10p.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb10p.rst
index 76a4d278e640..dc52e827b5d3 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-srggb10p.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-srggb10p.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-SRGGB10P:
 .. _v4l2-pix-fmt-sbggr10p:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb12.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb12.rst
index 98ae80b968ae..15c34e1e4835 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-srggb12.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-srggb12.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-SRGGB12:
 .. _v4l2-pix-fmt-sbggr12:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb12p.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb12p.rst
index 7309dd7fa60f..a2f8ebfceb84 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-srggb12p.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-srggb12p.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-SRGGB12P:
 .. _v4l2-pix-fmt-sbggr12p:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb14.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb14.rst
index a4c7a392fe7f..7e5d45f30cab 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-srggb14.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-srggb14.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-SRGGB14:
 .. _v4l2-pix-fmt-sbggr14:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb14p.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb14p.rst
index e2f5a2b36092..e25baedfca77 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-srggb14p.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-srggb14p.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-SRGGB14P:
 .. _v4l2-pix-fmt-sbggr14p:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb16.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb16.rst
index 885f0d1f331d..93a210e22592 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-srggb16.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-srggb16.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-SRGGB16:
 .. _v4l2-pix-fmt-sbggr16:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb8.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb8.rst
index c275e6ef09f9..81e72f115994 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-srggb8.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-srggb8.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-SRGGB8:
 .. _v4l2-pix-fmt-sbggr8:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-tch-td08.rst b/Documentation/userspace-api/media/v4l/pixfmt-tch-td08.rst
index 165c9be2bfc5..ec89f43c60ec 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-tch-td08.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-tch-td08.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-TCH-FMT-DELTA-TD08:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-tch-td16.rst b/Documentation/userspace-api/media/v4l/pixfmt-tch-td16.rst
index 6dca01182175..7b59a6424243 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-tch-td16.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-tch-td16.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-TCH-FMT-DELTA-TD16:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-tch-tu08.rst b/Documentation/userspace-api/media/v4l/pixfmt-tch-tu08.rst
index f1380b72977f..63c5264b8668 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-tch-tu08.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-tch-tu08.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-TCH-FMT-TU08:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-tch-tu16.rst b/Documentation/userspace-api/media/v4l/pixfmt-tch-tu16.rst
index 2b9e1b15abcf..ade618a037a8 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-tch-tu16.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-tch-tu16.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-TCH-FMT-TU16:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-uv8.rst b/Documentation/userspace-api/media/v4l/pixfmt-uv8.rst
index a36c1a4d64a4..ff1d73ef5dba 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-uv8.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-uv8.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-UV8:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-uyvy.rst b/Documentation/userspace-api/media/v4l/pixfmt-uyvy.rst
index 776cb37f76f1..bae975fb14f6 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-uyvy.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-uyvy.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-UYVY:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-v4l2-mplane.rst b/Documentation/userspace-api/media/v4l/pixfmt-v4l2-mplane.rst
index 444b4082684c..ac82882135ae 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-v4l2-mplane.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-v4l2-mplane.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 ******************************
 Multi-planar format structures
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-v4l2.rst b/Documentation/userspace-api/media/v4l/pixfmt-v4l2.rst
index e0ee2823ab1f..146f8c250afe 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-v4l2.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-v4l2.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 ******************************
 Single-planar format structure
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-vyuy.rst b/Documentation/userspace-api/media/v4l/pixfmt-vyuy.rst
index 6cd574e78e4c..aff8588b67a9 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-vyuy.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-vyuy.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-VYUY:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-y10.rst b/Documentation/userspace-api/media/v4l/pixfmt-y10.rst
index dfb352ae6784..05f018dd883f 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-y10.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-y10.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-Y10:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-y10b.rst b/Documentation/userspace-api/media/v4l/pixfmt-y10b.rst
index b5d89d6d5c52..38d353b37df9 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-y10b.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-y10b.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-Y10BPACK:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-y10p.rst b/Documentation/userspace-api/media/v4l/pixfmt-y10p.rst
index ffb6e1631b78..dd20d3438732 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-y10p.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-y10p.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-Y10P:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-y12.rst b/Documentation/userspace-api/media/v4l/pixfmt-y12.rst
index 4226c49232de..20e12a18da72 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-y12.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-y12.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-Y12:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-y12i.rst b/Documentation/userspace-api/media/v4l/pixfmt-y12i.rst
index b4752754337b..d9b539381d74 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-y12i.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-y12i.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-Y12I:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-y14.rst b/Documentation/userspace-api/media/v4l/pixfmt-y14.rst
index d702b6549160..2a4826b77105 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-y14.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-y14.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-Y14:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-y16-be.rst b/Documentation/userspace-api/media/v4l/pixfmt-y16-be.rst
index f4eda7b95b51..6d70cd78cbf6 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-y16-be.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-y16-be.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-Y16-BE:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-y16.rst b/Documentation/userspace-api/media/v4l/pixfmt-y16.rst
index a092b0a5ff12..398ad8ba5d64 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-y16.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-y16.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-Y16:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-y41p.rst b/Documentation/userspace-api/media/v4l/pixfmt-y41p.rst
index 211afd7593cc..d14cedf8f317 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-y41p.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-y41p.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-Y41P:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-y8i.rst b/Documentation/userspace-api/media/v4l/pixfmt-y8i.rst
index 4248c6f735b7..770ed4749c14 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-y8i.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-y8i.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-Y8I:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv410.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv410.rst
index 1d20115f2b1d..de2e519adc60 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv410.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv410.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-YVU410:
 .. _v4l2-pix-fmt-yuv410:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv411p.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv411p.rst
index 967ba7ce41a2..998aa9b1328f 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv411p.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv411p.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-YUV411P:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv420.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv420.rst
index 7cb685cc8289..f1c7baf32685 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv420.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv420.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-YVU420:
 .. _V4L2-PIX-FMT-YUV420:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv420m.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv420m.rst
index 80c14d4f5acb..cd20a57e0621 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv420m.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv420m.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-YUV420M:
 .. _v4l2-pix-fmt-yvu420m:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv422m.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv422m.rst
index 29b78480ccad..32bf15e1426e 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv422m.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv422m.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-YUV422M:
 .. _v4l2-pix-fmt-yvu422m:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv422p.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv422p.rst
index 73fde222d820..b178be558361 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv422p.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv422p.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-YUV422P:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv444m.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv444m.rst
index 7073ac7f842d..90bdee2e2b0d 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv444m.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv444m.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-YUV444M:
 .. _v4l2-pix-fmt-yvu444m:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuyv.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuyv.rst
index fe70e007787d..ca073a5098a9 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuyv.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuyv.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-YUYV:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yvyu.rst b/Documentation/userspace-api/media/v4l/pixfmt-yvyu.rst
index 96c1b537d5a0..81ebec525ae5 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yvyu.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yvyu.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-YVYU:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-z16.rst b/Documentation/userspace-api/media/v4l/pixfmt-z16.rst
index fe2fb21edeea..54a8cd723d1a 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-z16.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-z16.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _V4L2-PIX-FMT-Z16:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt.rst b/Documentation/userspace-api/media/v4l/pixfmt.rst
index 70ca3a5c2cf1..11dab4a90630 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _pixfmt:
 
diff --git a/Documentation/userspace-api/media/v4l/planar-apis.rst b/Documentation/userspace-api/media/v4l/planar-apis.rst
index 6247b0c4ab4d..9207ce4283df 100644
--- a/Documentation/userspace-api/media/v4l/planar-apis.rst
+++ b/Documentation/userspace-api/media/v4l/planar-apis.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _planar-apis:
 
diff --git a/Documentation/userspace-api/media/v4l/querycap.rst b/Documentation/userspace-api/media/v4l/querycap.rst
index 35fba2a9e09b..15a90271af45 100644
--- a/Documentation/userspace-api/media/v4l/querycap.rst
+++ b/Documentation/userspace-api/media/v4l/querycap.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _querycap:
 
diff --git a/Documentation/userspace-api/media/v4l/rw.rst b/Documentation/userspace-api/media/v4l/rw.rst
index ce2768c994d0..43609a27c3ec 100644
--- a/Documentation/userspace-api/media/v4l/rw.rst
+++ b/Documentation/userspace-api/media/v4l/rw.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _rw:
 
diff --git a/Documentation/userspace-api/media/v4l/sdr-formats.rst b/Documentation/userspace-api/media/v4l/sdr-formats.rst
index b7a1be75251f..d8bdfdb56911 100644
--- a/Documentation/userspace-api/media/v4l/sdr-formats.rst
+++ b/Documentation/userspace-api/media/v4l/sdr-formats.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _sdr-formats:
 
diff --git a/Documentation/userspace-api/media/v4l/selection-api-configuration.rst b/Documentation/userspace-api/media/v4l/selection-api-configuration.rst
index 67ff67fd734e..37617eda2fa6 100644
--- a/Documentation/userspace-api/media/v4l/selection-api-configuration.rst
+++ b/Documentation/userspace-api/media/v4l/selection-api-configuration.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 *************
 Configuration
diff --git a/Documentation/userspace-api/media/v4l/selection-api-examples.rst b/Documentation/userspace-api/media/v4l/selection-api-examples.rst
index 2f4027211129..5f8e8a1f59d7 100644
--- a/Documentation/userspace-api/media/v4l/selection-api-examples.rst
+++ b/Documentation/userspace-api/media/v4l/selection-api-examples.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 ********
 Examples
diff --git a/Documentation/userspace-api/media/v4l/selection-api-intro.rst b/Documentation/userspace-api/media/v4l/selection-api-intro.rst
index 0994ca25be5e..6534854ae9f7 100644
--- a/Documentation/userspace-api/media/v4l/selection-api-intro.rst
+++ b/Documentation/userspace-api/media/v4l/selection-api-intro.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 ************
 Introduction
diff --git a/Documentation/userspace-api/media/v4l/selection-api-targets.rst b/Documentation/userspace-api/media/v4l/selection-api-targets.rst
index 56eab969c9d8..50fdadd5b307 100644
--- a/Documentation/userspace-api/media/v4l/selection-api-targets.rst
+++ b/Documentation/userspace-api/media/v4l/selection-api-targets.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 *****************
 Selection targets
diff --git a/Documentation/userspace-api/media/v4l/selection-api-vs-crop-api.rst b/Documentation/userspace-api/media/v4l/selection-api-vs-crop-api.rst
index a9360a000022..f57b9180012c 100644
--- a/Documentation/userspace-api/media/v4l/selection-api-vs-crop-api.rst
+++ b/Documentation/userspace-api/media/v4l/selection-api-vs-crop-api.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _selection-vs-crop:
 
diff --git a/Documentation/userspace-api/media/v4l/selection-api.rst b/Documentation/userspace-api/media/v4l/selection-api.rst
index b86e387721df..0360743746dc 100644
--- a/Documentation/userspace-api/media/v4l/selection-api.rst
+++ b/Documentation/userspace-api/media/v4l/selection-api.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _selection-api:
 
diff --git a/Documentation/userspace-api/media/v4l/selections-common.rst b/Documentation/userspace-api/media/v4l/selections-common.rst
index d5ea05869a61..322b39cf0eba 100644
--- a/Documentation/userspace-api/media/v4l/selections-common.rst
+++ b/Documentation/userspace-api/media/v4l/selections-common.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _v4l2-selections-common:
 
diff --git a/Documentation/userspace-api/media/v4l/standard.rst b/Documentation/userspace-api/media/v4l/standard.rst
index 61c341508eb3..1f6678325da9 100644
--- a/Documentation/userspace-api/media/v4l/standard.rst
+++ b/Documentation/userspace-api/media/v4l/standard.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _standard:
 
diff --git a/Documentation/userspace-api/media/v4l/streaming-par.rst b/Documentation/userspace-api/media/v4l/streaming-par.rst
index 6d1a1b93ac8b..cc2e8fcecc7e 100644
--- a/Documentation/userspace-api/media/v4l/streaming-par.rst
+++ b/Documentation/userspace-api/media/v4l/streaming-par.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _streaming-par:
 
diff --git a/Documentation/userspace-api/media/v4l/subdev-formats.rst b/Documentation/userspace-api/media/v4l/subdev-formats.rst
index 9a4d61b0d76f..dd2f037b74dd 100644
--- a/Documentation/userspace-api/media/v4l/subdev-formats.rst
+++ b/Documentation/userspace-api/media/v4l/subdev-formats.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _v4l2-mbus-format:
 
diff --git a/Documentation/userspace-api/media/v4l/tch-formats.rst b/Documentation/userspace-api/media/v4l/tch-formats.rst
index f83aec85fd76..8c941ff9e200 100644
--- a/Documentation/userspace-api/media/v4l/tch-formats.rst
+++ b/Documentation/userspace-api/media/v4l/tch-formats.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _tch-formats:
 
diff --git a/Documentation/userspace-api/media/v4l/tuner.rst b/Documentation/userspace-api/media/v4l/tuner.rst
index 02a396eb6613..e2c53c3abdc6 100644
--- a/Documentation/userspace-api/media/v4l/tuner.rst
+++ b/Documentation/userspace-api/media/v4l/tuner.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _tuner:
 
diff --git a/Documentation/userspace-api/media/v4l/user-func.rst b/Documentation/userspace-api/media/v4l/user-func.rst
index bf77c842718e..53e604bd7d60 100644
--- a/Documentation/userspace-api/media/v4l/user-func.rst
+++ b/Documentation/userspace-api/media/v4l/user-func.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _user-func:
 
diff --git a/Documentation/userspace-api/media/v4l/userp.rst b/Documentation/userspace-api/media/v4l/userp.rst
index 2d0fa7353066..5b7321907dab 100644
--- a/Documentation/userspace-api/media/v4l/userp.rst
+++ b/Documentation/userspace-api/media/v4l/userp.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _userp:
 
diff --git a/Documentation/userspace-api/media/v4l/v4l2-selection-flags.rst b/Documentation/userspace-api/media/v4l/v4l2-selection-flags.rst
index 5c6f351b2443..3a834d050110 100644
--- a/Documentation/userspace-api/media/v4l/v4l2-selection-flags.rst
+++ b/Documentation/userspace-api/media/v4l/v4l2-selection-flags.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _v4l2-selection-flags:
 
diff --git a/Documentation/userspace-api/media/v4l/v4l2-selection-targets.rst b/Documentation/userspace-api/media/v4l/v4l2-selection-targets.rst
index 69f500093aa2..e877ebbdb32e 100644
--- a/Documentation/userspace-api/media/v4l/v4l2-selection-targets.rst
+++ b/Documentation/userspace-api/media/v4l/v4l2-selection-targets.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _v4l2-selection-targets:
 
diff --git a/Documentation/userspace-api/media/v4l/v4l2.rst b/Documentation/userspace-api/media/v4l/v4l2.rst
index 35796c4fbe52..ad7a2bf0cf26 100644
--- a/Documentation/userspace-api/media/v4l/v4l2.rst
+++ b/Documentation/userspace-api/media/v4l/v4l2.rst
@@ -1,13 +1,6 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
-
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 .. include:: <isonum.txt>
+
 .. _v4l2spec:
 
 ############################
diff --git a/Documentation/userspace-api/media/v4l/v4l2grab-example.rst b/Documentation/userspace-api/media/v4l/v4l2grab-example.rst
index 270738876f72..b323be42c580 100644
--- a/Documentation/userspace-api/media/v4l/v4l2grab-example.rst
+++ b/Documentation/userspace-api/media/v4l/v4l2grab-example.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _v4l2grab-example:
 
diff --git a/Documentation/userspace-api/media/v4l/v4l2grab.c.rst b/Documentation/userspace-api/media/v4l/v4l2grab.c.rst
index a21ff357a830..eaa0f95048e7 100644
--- a/Documentation/userspace-api/media/v4l/v4l2grab.c.rst
+++ b/Documentation/userspace-api/media/v4l/v4l2grab.c.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 file: media/v4l/v4l2grab.c
 ==========================
diff --git a/Documentation/userspace-api/media/v4l/video.rst b/Documentation/userspace-api/media/v4l/video.rst
index 9b73dba0eb8d..f8f69a57602c 100644
--- a/Documentation/userspace-api/media/v4l/video.rst
+++ b/Documentation/userspace-api/media/v4l/video.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _video:
 
diff --git a/Documentation/userspace-api/media/v4l/videodev.rst b/Documentation/userspace-api/media/v4l/videodev.rst
index c8244b895802..c866fec417eb 100644
--- a/Documentation/userspace-api/media/v4l/videodev.rst
+++ b/Documentation/userspace-api/media/v4l/videodev.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _videodev:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst b/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst
index f2a702870fad..c050dffa4237 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_CREATE_BUFS:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-cropcap.rst b/Documentation/userspace-api/media/v4l/vidioc-cropcap.rst
index 035ed9d577ae..aa02c312824e 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-cropcap.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-cropcap.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_CROPCAP:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-dbg-g-chip-info.rst b/Documentation/userspace-api/media/v4l/vidioc-dbg-g-chip-info.rst
index 16078a2d3e3d..a2541329b30a 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-dbg-g-chip-info.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-dbg-g-chip-info.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_DBG_G_CHIP_INFO:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-dbg-g-register.rst b/Documentation/userspace-api/media/v4l/vidioc-dbg-g-register.rst
index 6311a63278a5..350a04eb0e86 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-dbg-g-register.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-dbg-g-register.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_DBG_G_REGISTER:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-decoder-cmd.rst b/Documentation/userspace-api/media/v4l/vidioc-decoder-cmd.rst
index 7986a248bff9..0ef757f061e3 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-decoder-cmd.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-decoder-cmd.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_DECODER_CMD:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst b/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
index 9412be0c3747..f0dfc8cf9b14 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_DQEVENT:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-dv-timings-cap.rst b/Documentation/userspace-api/media/v4l/vidioc-dv-timings-cap.rst
index 60730c32bfe4..82bb732893be 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-dv-timings-cap.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-dv-timings-cap.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_DV_TIMINGS_CAP:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-encoder-cmd.rst b/Documentation/userspace-api/media/v4l/vidioc-encoder-cmd.rst
index d0eacce5485e..44aad55d9459 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-encoder-cmd.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-encoder-cmd.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_ENCODER_CMD:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enum-dv-timings.rst b/Documentation/userspace-api/media/v4l/vidioc-enum-dv-timings.rst
index 89d6b860193a..bb74096cfbd8 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-enum-dv-timings.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-enum-dv-timings.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_ENUM_DV_TIMINGS:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst b/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst
index 05835e04c20b..296b7d437431 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_ENUM_FMT:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enum-frameintervals.rst b/Documentation/userspace-api/media/v4l/vidioc-enum-frameintervals.rst
index 0e3db737371f..68469756e6c7 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-enum-frameintervals.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-enum-frameintervals.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_ENUM_FRAMEINTERVALS:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enum-framesizes.rst b/Documentation/userspace-api/media/v4l/vidioc-enum-framesizes.rst
index 1934d7da9743..dc4e0e216e7e 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-enum-framesizes.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-enum-framesizes.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_ENUM_FRAMESIZES:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enum-freq-bands.rst b/Documentation/userspace-api/media/v4l/vidioc-enum-freq-bands.rst
index ee3ba67601fa..2dabf542b20f 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-enum-freq-bands.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-enum-freq-bands.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_ENUM_FREQ_BANDS:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enumaudio.rst b/Documentation/userspace-api/media/v4l/vidioc-enumaudio.rst
index afe4821e5863..6cf06ac0bb70 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-enumaudio.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-enumaudio.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_ENUMAUDIO:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enumaudioout.rst b/Documentation/userspace-api/media/v4l/vidioc-enumaudioout.rst
index 31c2ae460e2d..b4a42ea397db 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-enumaudioout.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-enumaudioout.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_ENUMAUDOUT:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enuminput.rst b/Documentation/userspace-api/media/v4l/vidioc-enuminput.rst
index 510670bff3de..714688f81e23 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-enuminput.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-enuminput.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_ENUMINPUT:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enumoutput.rst b/Documentation/userspace-api/media/v4l/vidioc-enumoutput.rst
index 591a99cf8000..272a0b2b475c 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-enumoutput.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-enumoutput.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_ENUMOUTPUT:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enumstd.rst b/Documentation/userspace-api/media/v4l/vidioc-enumstd.rst
index 8a0508536c13..85bc6d0231f1 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-enumstd.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-enumstd.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_ENUMSTD:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-expbuf.rst b/Documentation/userspace-api/media/v4l/vidioc-expbuf.rst
index 384a9be9eba0..a2c475a83a58 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-expbuf.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-expbuf.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_EXPBUF:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-audio.rst b/Documentation/userspace-api/media/v4l/vidioc-g-audio.rst
index 68531bcb62ab..38667864355a 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-audio.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-audio.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_AUDIO:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-audioout.rst b/Documentation/userspace-api/media/v4l/vidioc-g-audioout.rst
index e13b74bf5ce3..5bf56723c7ba 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-audioout.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-audioout.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_AUDOUT:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-crop.rst b/Documentation/userspace-api/media/v4l/vidioc-g-crop.rst
index 10e086be55d5..735a6bf5e025 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-crop.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-crop.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_CROP:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-ctrl.rst b/Documentation/userspace-api/media/v4l/vidioc-g-ctrl.rst
index 9831b7514028..d863c849be95 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-ctrl.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-ctrl.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_CTRL:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-dv-timings.rst b/Documentation/userspace-api/media/v4l/vidioc-g-dv-timings.rst
index 9a035a4ea0f0..e5a58db574d4 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-dv-timings.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-dv-timings.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_DV_TIMINGS:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-edid.rst b/Documentation/userspace-api/media/v4l/vidioc-g-edid.rst
index 0620f4cbbcbd..6a9ed2915cb9 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-edid.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-edid.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_EDID:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-enc-index.rst b/Documentation/userspace-api/media/v4l/vidioc-g-enc-index.rst
index 8aad30a7c6c3..99cddf3b9888 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-enc-index.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-enc-index.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_ENC_INDEX:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst b/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
index add17c9204cb..0991af626591 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_EXT_CTRLS:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-fbuf.rst b/Documentation/userspace-api/media/v4l/vidioc-g-fbuf.rst
index 0124444419ae..7e1a0b812754 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-fbuf.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-fbuf.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_FBUF:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-fmt.rst b/Documentation/userspace-api/media/v4l/vidioc-g-fmt.rst
index 88bb69ec07e2..7d113451bfbc 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-fmt.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-fmt.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_FMT:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-frequency.rst b/Documentation/userspace-api/media/v4l/vidioc-g-frequency.rst
index 26300e0258a3..da0d5dee72ff 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-frequency.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-frequency.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_FREQUENCY:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-input.rst b/Documentation/userspace-api/media/v4l/vidioc-g-input.rst
index 294e346678c1..f4637bc464f6 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-input.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-input.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_INPUT:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-jpegcomp.rst b/Documentation/userspace-api/media/v4l/vidioc-g-jpegcomp.rst
index 3b9981dcb8e0..8721adc5ad70 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-jpegcomp.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-jpegcomp.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_JPEGCOMP:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-modulator.rst b/Documentation/userspace-api/media/v4l/vidioc-g-modulator.rst
index c2072f6e8756..baf499d0df74 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-modulator.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-modulator.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_MODULATOR:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-output.rst b/Documentation/userspace-api/media/v4l/vidioc-g-output.rst
index cad477420fd7..0afc55c67840 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-output.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-output.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_OUTPUT:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-parm.rst b/Documentation/userspace-api/media/v4l/vidioc-g-parm.rst
index 59e02aca164c..94f3af279bba 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-parm.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-parm.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_PARM:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-priority.rst b/Documentation/userspace-api/media/v4l/vidioc-g-priority.rst
index c8add130c7a4..da3166ac6d08 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-priority.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-priority.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_PRIORITY:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-selection.rst b/Documentation/userspace-api/media/v4l/vidioc-g-selection.rst
index faab0454b1e4..cda7a69ea130 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-selection.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-selection.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_SELECTION:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-sliced-vbi-cap.rst b/Documentation/userspace-api/media/v4l/vidioc-g-sliced-vbi-cap.rst
index 7a62c4f4e37f..a3a7fb00350f 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-sliced-vbi-cap.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-sliced-vbi-cap.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_SLICED_VBI_CAP:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-std.rst b/Documentation/userspace-api/media/v4l/vidioc-g-std.rst
index 6d8cb7f29ac6..8a659a873528 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-std.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-std.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_STD:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-tuner.rst b/Documentation/userspace-api/media/v4l/vidioc-g-tuner.rst
index 40bff6f0a88d..e3ba5b18a357 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-tuner.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-tuner.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_G_TUNER:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-log-status.rst b/Documentation/userspace-api/media/v4l/vidioc-log-status.rst
index 64c06fa72b9c..74b06dc68109 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-log-status.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-log-status.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_LOG_STATUS:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-overlay.rst b/Documentation/userspace-api/media/v4l/vidioc-overlay.rst
index 74310ff486ba..8553fc7a6d8b 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-overlay.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-overlay.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_OVERLAY:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-prepare-buf.rst b/Documentation/userspace-api/media/v4l/vidioc-prepare-buf.rst
index b6c09d5b128f..df003e5a65ac 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-prepare-buf.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-prepare-buf.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_PREPARE_BUF:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-qbuf.rst b/Documentation/userspace-api/media/v4l/vidioc-qbuf.rst
index ec0a54fbeb43..cd920d0b6adf 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-qbuf.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-qbuf.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_QBUF:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-query-dv-timings.rst b/Documentation/userspace-api/media/v4l/vidioc-query-dv-timings.rst
index ab86408446f3..6942e7e76897 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-query-dv-timings.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-query-dv-timings.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_QUERY_DV_TIMINGS:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-querybuf.rst b/Documentation/userspace-api/media/v4l/vidioc-querybuf.rst
index 646f91140ccf..1d7ecf2697af 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-querybuf.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-querybuf.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_QUERYBUF:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-querycap.rst b/Documentation/userspace-api/media/v4l/vidioc-querycap.rst
index 90347367ef06..80b7b79561f5 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-querycap.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-querycap.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_QUERYCAP:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst b/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
index fbb0038d86bf..559ad849f7b9 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_QUERYCTRL:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-querystd.rst b/Documentation/userspace-api/media/v4l/vidioc-querystd.rst
index 899f0ef6eefe..b043ec48cf9d 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-querystd.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-querystd.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_QUERYSTD:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
index 75d894d9c36c..47e433161690 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_REQBUFS:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-s-hw-freq-seek.rst b/Documentation/userspace-api/media/v4l/vidioc-s-hw-freq-seek.rst
index 4c16e7e89cfa..fb09ea31cad7 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-s-hw-freq-seek.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-s-hw-freq-seek.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_S_HW_FREQ_SEEK:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-streamon.rst b/Documentation/userspace-api/media/v4l/vidioc-streamon.rst
index 13e0136d5c25..d9623aa7c425 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-streamon.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-streamon.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_STREAMON:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-interval.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-interval.rst
index 3527745935c7..932e8416f11c 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-interval.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-interval.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_SUBDEV_ENUM_FRAME_INTERVAL:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-size.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-size.rst
index eb7401991d02..3c480573df59 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-size.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-size.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_SUBDEV_ENUM_FRAME_SIZE:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst
index 35b8607203a4..9db76f7d240f 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_SUBDEV_ENUM_MBUS_CODE:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-g-crop.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-g-crop.rst
index 615e3efdf935..45c988b13ba6 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-subdev-g-crop.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-g-crop.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_SUBDEV_G_CROP:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-g-fmt.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-g-fmt.rst
index 909ee9f90867..76ce46f53c76 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-subdev-g-fmt.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-g-fmt.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_SUBDEV_G_FMT:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-g-frame-interval.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-g-frame-interval.rst
index 51e1bff797f0..7e0b177e70aa 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-subdev-g-frame-interval.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-g-frame-interval.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_SUBDEV_G_FRAME_INTERVAL:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-g-selection.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-g-selection.rst
index 06c9553ac48f..948903a34d6f 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-subdev-g-selection.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-g-selection.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_SUBDEV_G_SELECTION:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-querycap.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-querycap.rst
index 0371a76321af..e806385ba176 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-subdev-querycap.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-querycap.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_SUBDEV_QUERYCAP:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-subscribe-event.rst b/Documentation/userspace-api/media/v4l/vidioc-subscribe-event.rst
index ae3ed73c0a9e..67827671bbaa 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-subscribe-event.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-subscribe-event.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _VIDIOC_SUBSCRIBE_EVENT:
 .. _VIDIOC_UNSUBSCRIBE_EVENT:
diff --git a/Documentation/userspace-api/media/v4l/yuv-formats.rst b/Documentation/userspace-api/media/v4l/yuv-formats.rst
index 8ee92d0cd769..4a05a105a9e6 100644
--- a/Documentation/userspace-api/media/v4l/yuv-formats.rst
+++ b/Documentation/userspace-api/media/v4l/yuv-formats.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
 
 .. _yuv-formats:
 
-- 
2.26.2

