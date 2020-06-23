Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B86BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4934D20724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592906013;
	bh=PefP4W4hLvPGcwowI1SB4SOm5+xEMeaXG10tXDCABYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zkOyBxvTun1+uPsTXEUtf/QkQavutMV2lbPZWlp0t7eayqp4rt/ls2h0QrZqeo0CY
	 VU139J6JrPuH4wWZMNHh1M3y3otrLifn20aJTOVeVm7xV1ayQ7XDVzHR9q8O6r938e
	 QvD5Tq03dPV993zeHeuNnoI6k8Cqr4a8TUgAGHWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbgFWJxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:53:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732202AbgFWJx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:53:26 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D3242078E;
        Tue, 23 Jun 2020 09:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592905987;
        bh=PefP4W4hLvPGcwowI1SB4SOm5+xEMeaXG10tXDCABYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eBGkzVD80R9qmOOgiLTaTNl9/L8be2vnLoYNICm9DERmBugO+SY0ur9JzOVinwivq
         kAORLaBW0J7ugz+N8KAjpAyM7aIqSNbMUJBl99ozJyl3SMCziTTWYiDgB59RI3G4fN
         /GFa/a55zrt+7kYW86LucVQw5oo2tIo58Elc3hSo=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jnfbz-004C3E-W1; Tue, 23 Jun 2020 11:53:04 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Yong Zhi <yong.zhi@intel.com>, linux-media@vger.kernel.org
Subject: [PATCH v2 3/9] media: docs: use SPDX GFDL-1.1-or-later-no-invariants
Date:   Tue, 23 Jun 2020 11:52:56 +0200
Message-Id: <60d373423025681b77c7a30e5131af65c12781a2.1592905407.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592905407.git.mchehab+huawei@kernel.org>
References: <cover.1592905407.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that SPDX added support for GFDL-1.1+ without invariant
sections, we can finnaly get rid of the ugly licensing text on
media documents.

This patch was done via some sed magic:

	sed '/^\.\. TODO:/,$!d' -i $(git grep -l "^.. TODO: replace it to" Documentation/)
	sed s,"TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections","SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants", -i $(git grep -l "^.. TODO: replace it to GFDL" Documentation/)
	sed s,"TODO: replace it to GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections","SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later-no-invariants", -i $(git grep -l "^.. TODO: replace it to" Documentation/)

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../userspace-api/media/cec/cec-api.rst       |  9 +------
 .../media/cec/cec-func-close.rst              |  9 +------
 .../media/cec/cec-func-ioctl.rst              |  9 +------
 .../userspace-api/media/cec/cec-func-open.rst |  9 +------
 .../userspace-api/media/cec/cec-func-poll.rst |  9 +------
 .../userspace-api/media/cec/cec-funcs.rst     |  9 +------
 .../userspace-api/media/cec/cec-header.rst    |  9 +------
 .../userspace-api/media/cec/cec-intro.rst     |  9 +------
 .../media/cec/cec-ioc-adap-g-caps.rst         |  9 +------
 .../media/cec/cec-ioc-adap-g-log-addrs.rst    |  9 +------
 .../media/cec/cec-ioc-adap-g-phys-addr.rst    |  9 +------
 .../media/cec/cec-ioc-dqevent.rst             |  9 +------
 .../media/cec/cec-ioc-g-mode.rst              |  9 +------
 .../media/cec/cec-ioc-receive.rst             |  9 +------
 .../media/cec/cec-pin-error-inj.rst           |  9 +------
 .../dvb/audio-bilingual-channel-select.rst    |  9 +------
 .../media/dvb/audio-channel-select.rst        |  9 +------
 .../media/dvb/audio-clear-buffer.rst          |  9 +------
 .../media/dvb/audio-continue.rst              |  9 +------
 .../userspace-api/media/dvb/audio-fclose.rst  |  9 +------
 .../userspace-api/media/dvb/audio-fopen.rst   |  9 +------
 .../userspace-api/media/dvb/audio-fwrite.rst  |  9 +------
 .../media/dvb/audio-get-capabilities.rst      |  9 +------
 .../media/dvb/audio-get-status.rst            |  9 +------
 .../userspace-api/media/dvb/audio-pause.rst   |  9 +------
 .../userspace-api/media/dvb/audio-play.rst    |  9 +------
 .../media/dvb/audio-select-source.rst         |  9 +------
 .../media/dvb/audio-set-av-sync.rst           |  9 +------
 .../media/dvb/audio-set-bypass-mode.rst       |  9 +------
 .../userspace-api/media/dvb/audio-set-id.rst  |  9 +------
 .../media/dvb/audio-set-mixer.rst             |  9 +------
 .../media/dvb/audio-set-mute.rst              |  9 +------
 .../media/dvb/audio-set-streamtype.rst        |  9 +------
 .../userspace-api/media/dvb/audio-stop.rst    |  9 +------
 .../userspace-api/media/dvb/audio.rst         |  9 +------
 .../media/dvb/audio_data_types.rst            |  9 +------
 .../media/dvb/audio_function_calls.rst        |  9 +------
 .../userspace-api/media/dvb/ca-fclose.rst     |  9 +------
 .../userspace-api/media/dvb/ca-fopen.rst      |  9 +------
 .../userspace-api/media/dvb/ca-get-cap.rst    |  9 +------
 .../media/dvb/ca-get-descr-info.rst           |  9 +------
 .../userspace-api/media/dvb/ca-get-msg.rst    |  9 +------
 .../media/dvb/ca-get-slot-info.rst            |  9 +------
 .../userspace-api/media/dvb/ca-reset.rst      |  9 +------
 .../userspace-api/media/dvb/ca-send-msg.rst   |  9 +------
 .../userspace-api/media/dvb/ca-set-descr.rst  |  9 +------
 Documentation/userspace-api/media/dvb/ca.rst  |  9 +------
 .../userspace-api/media/dvb/ca_data_types.rst |  9 +------
 .../media/dvb/ca_function_calls.rst           |  9 +------
 .../userspace-api/media/dvb/demux.rst         |  9 +------
 .../userspace-api/media/dvb/dmx-add-pid.rst   |  9 +------
 .../userspace-api/media/dvb/dmx-expbuf.rst    |  9 +------
 .../userspace-api/media/dvb/dmx-fclose.rst    |  9 +------
 .../userspace-api/media/dvb/dmx-fopen.rst     |  9 +------
 .../userspace-api/media/dvb/dmx-fread.rst     |  9 +------
 .../userspace-api/media/dvb/dmx-fwrite.rst    |  9 +------
 .../media/dvb/dmx-get-pes-pids.rst            |  9 +------
 .../userspace-api/media/dvb/dmx-get-stc.rst   |  9 +------
 .../userspace-api/media/dvb/dmx-mmap.rst      |  9 +------
 .../userspace-api/media/dvb/dmx-munmap.rst    |  9 +------
 .../userspace-api/media/dvb/dmx-qbuf.rst      |  9 +------
 .../userspace-api/media/dvb/dmx-querybuf.rst  |  9 +------
 .../media/dvb/dmx-remove-pid.rst              |  9 +------
 .../userspace-api/media/dvb/dmx-reqbufs.rst   |  9 +------
 .../media/dvb/dmx-set-buffer-size.rst         |  9 +------
 .../media/dvb/dmx-set-filter.rst              |  9 +------
 .../media/dvb/dmx-set-pes-filter.rst          |  9 +------
 .../userspace-api/media/dvb/dmx-start.rst     |  9 +------
 .../userspace-api/media/dvb/dmx-stop.rst      |  9 +------
 .../userspace-api/media/dvb/dmx_fcalls.rst    |  9 +------
 .../userspace-api/media/dvb/dmx_types.rst     |  9 +------
 .../media/dvb/dvb-fe-read-status.rst          |  9 +------
 .../media/dvb/dvb-frontend-event.rst          |  9 +------
 .../media/dvb/dvb-frontend-parameters.rst     |  9 +------
 .../userspace-api/media/dvb/dvbapi.rst        |  9 +------
 .../userspace-api/media/dvb/dvbproperty.rst   |  9 +------
 .../userspace-api/media/dvb/examples.rst      |  9 +------
 .../media/dvb/fe-bandwidth-t.rst              |  9 +------
 .../media/dvb/fe-diseqc-recv-slave-reply.rst  |  9 +------
 .../media/dvb/fe-diseqc-reset-overload.rst    |  9 +------
 .../media/dvb/fe-diseqc-send-burst.rst        |  9 +------
 .../media/dvb/fe-diseqc-send-master-cmd.rst   |  9 +------
 .../dvb/fe-dishnetwork-send-legacy-cmd.rst    |  9 +------
 .../media/dvb/fe-enable-high-lnb-voltage.rst  |  9 +------
 .../userspace-api/media/dvb/fe-get-event.rst  |  9 +------
 .../media/dvb/fe-get-frontend.rst             |  9 +------
 .../userspace-api/media/dvb/fe-get-info.rst   |  9 +------
 .../media/dvb/fe-get-property.rst             |  9 +------
 .../userspace-api/media/dvb/fe-read-ber.rst   |  9 +------
 .../media/dvb/fe-read-signal-strength.rst     |  9 +------
 .../userspace-api/media/dvb/fe-read-snr.rst   |  9 +------
 .../media/dvb/fe-read-status.rst              |  9 +------
 .../media/dvb/fe-read-uncorrected-blocks.rst  |  9 +------
 .../media/dvb/fe-set-frontend-tune-mode.rst   |  9 +------
 .../media/dvb/fe-set-frontend.rst             |  9 +------
 .../userspace-api/media/dvb/fe-set-tone.rst   |  9 +------
 .../media/dvb/fe-set-voltage.rst              |  9 +------
 .../userspace-api/media/dvb/fe-type-t.rst     |  9 +------
 .../media/dvb/fe_property_parameters.rst      |  9 +------
 .../media/dvb/frontend-header.rst             |  9 +------
 .../dvb/frontend-property-cable-systems.rst   |  9 +------
 .../frontend-property-satellite-systems.rst   |  9 +------
 .../frontend-property-terrestrial-systems.rst |  9 +------
 .../media/dvb/frontend-stat-properties.rst    |  9 +------
 .../userspace-api/media/dvb/frontend.rst      |  9 +------
 .../media/dvb/frontend_f_close.rst            |  9 +------
 .../media/dvb/frontend_f_open.rst             |  9 +------
 .../media/dvb/frontend_fcalls.rst             |  9 +------
 .../media/dvb/frontend_legacy_api.rst         |  9 +------
 .../media/dvb/frontend_legacy_dvbv3_api.rst   |  9 +------
 .../userspace-api/media/dvb/headers.rst       |  9 +------
 .../userspace-api/media/dvb/intro.rst         |  9 +------
 .../media/dvb/legacy_dvb_apis.rst             |  9 +------
 .../userspace-api/media/dvb/net-add-if.rst    |  9 +------
 .../userspace-api/media/dvb/net-get-if.rst    |  9 +------
 .../userspace-api/media/dvb/net-remove-if.rst |  9 +------
 .../userspace-api/media/dvb/net-types.rst     |  9 +------
 Documentation/userspace-api/media/dvb/net.rst |  9 +------
 .../media/dvb/query-dvb-frontend-info.rst     |  9 +------
 .../media/dvb/video-clear-buffer.rst          |  9 +------
 .../userspace-api/media/dvb/video-command.rst |  9 +------
 .../media/dvb/video-continue.rst              |  9 +------
 .../media/dvb/video-fast-forward.rst          |  9 +------
 .../userspace-api/media/dvb/video-fclose.rst  |  9 +------
 .../userspace-api/media/dvb/video-fopen.rst   |  9 +------
 .../userspace-api/media/dvb/video-freeze.rst  |  9 +------
 .../userspace-api/media/dvb/video-fwrite.rst  |  9 +------
 .../media/dvb/video-get-capabilities.rst      |  9 +------
 .../media/dvb/video-get-event.rst             |  9 +------
 .../media/dvb/video-get-frame-count.rst       |  9 +------
 .../userspace-api/media/dvb/video-get-pts.rst |  9 +------
 .../media/dvb/video-get-size.rst              |  9 +------
 .../media/dvb/video-get-status.rst            |  9 +------
 .../userspace-api/media/dvb/video-play.rst    |  9 +------
 .../media/dvb/video-select-source.rst         |  9 +------
 .../media/dvb/video-set-blank.rst             |  9 +------
 .../media/dvb/video-set-display-format.rst    |  9 +------
 .../media/dvb/video-set-format.rst            |  9 +------
 .../media/dvb/video-set-streamtype.rst        |  9 +------
 .../media/dvb/video-slowmotion.rst            |  9 +------
 .../media/dvb/video-stillpicture.rst          |  9 +------
 .../userspace-api/media/dvb/video-stop.rst    |  9 +------
 .../media/dvb/video-try-command.rst           |  9 +------
 .../userspace-api/media/dvb/video.rst         |  9 +------
 .../media/dvb/video_function_calls.rst        |  9 +------
 .../userspace-api/media/dvb/video_types.rst   |  9 +------
 .../userspace-api/media/fdl-appendix.rst      |  9 +------
 .../userspace-api/media/gen-errors.rst        |  9 +------
 .../media/mediactl/media-controller-intro.rst |  9 +------
 .../media/mediactl/media-controller-model.rst |  9 +------
 .../media/mediactl/media-controller.rst       |  9 +------
 .../media/mediactl/media-func-close.rst       |  9 +------
 .../media/mediactl/media-func-ioctl.rst       |  9 +------
 .../media/mediactl/media-func-open.rst        |  9 +------
 .../media/mediactl/media-funcs.rst            |  9 +------
 .../media/mediactl/media-header.rst           |  9 +------
 .../media/mediactl/media-ioc-device-info.rst  |  9 +------
 .../mediactl/media-ioc-enum-entities.rst      |  9 +------
 .../media/mediactl/media-ioc-enum-links.rst   |  9 +------
 .../media/mediactl/media-ioc-g-topology.rst   |  9 +------
 .../mediactl/media-ioc-request-alloc.rst      | 26 +------------------
 .../media/mediactl/media-ioc-setup-link.rst   |  9 +------
 .../mediactl/media-request-ioc-queue.rst      | 26 +------------------
 .../mediactl/media-request-ioc-reinit.rst     | 26 +------------------
 .../media/mediactl/media-types.rst            |  9 +------
 .../media/mediactl/request-api.rst            | 26 +------------------
 .../media/mediactl/request-func-close.rst     | 26 +------------------
 .../media/mediactl/request-func-ioctl.rst     | 26 +------------------
 .../media/mediactl/request-func-poll.rst      | 26 +------------------
 .../userspace-api/media/rc/keytable.c.rst     |  9 +------
 .../userspace-api/media/rc/lirc-dev-intro.rst |  9 +------
 .../userspace-api/media/rc/lirc-dev.rst       |  9 +------
 .../userspace-api/media/rc/lirc-func.rst      |  9 +------
 .../media/rc/lirc-get-features.rst            |  9 +------
 .../media/rc/lirc-get-rec-mode.rst            |  9 +------
 .../media/rc/lirc-get-rec-resolution.rst      |  9 +------
 .../media/rc/lirc-get-send-mode.rst           |  9 +------
 .../media/rc/lirc-get-timeout.rst             |  9 +------
 .../userspace-api/media/rc/lirc-header.rst    |  9 +------
 .../userspace-api/media/rc/lirc-read.rst      |  9 +------
 .../rc/lirc-set-measure-carrier-mode.rst      |  9 +------
 .../media/rc/lirc-set-rec-carrier-range.rst   |  9 +------
 .../media/rc/lirc-set-rec-carrier.rst         |  9 +------
 .../media/rc/lirc-set-rec-timeout-reports.rst |  9 +------
 .../media/rc/lirc-set-rec-timeout.rst         |  9 +------
 .../media/rc/lirc-set-send-carrier.rst        |  9 +------
 .../media/rc/lirc-set-send-duty-cycle.rst     |  9 +------
 .../media/rc/lirc-set-transmitter-mask.rst    |  9 +------
 .../media/rc/lirc-set-wideband-receiver.rst   |  9 +------
 .../userspace-api/media/rc/lirc-write.rst     |  9 +------
 .../userspace-api/media/rc/rc-intro.rst       |  9 +------
 .../userspace-api/media/rc/rc-protos.rst      |  4 +--
 .../userspace-api/media/rc/rc-sysfs-nodes.rst |  9 +------
 .../media/rc/rc-table-change.rst              |  9 +------
 .../userspace-api/media/rc/rc-tables.rst      |  9 +------
 .../media/rc/remote_controllers.rst           |  9 +------
 .../userspace-api/media/v4l/app-pri.rst       |  9 +------
 .../userspace-api/media/v4l/async.rst         |  9 +------
 .../userspace-api/media/v4l/audio.rst         |  9 +------
 .../userspace-api/media/v4l/biblio.rst        |  9 +------
 .../userspace-api/media/v4l/buffer.rst        |  9 +------
 .../media/v4l/capture-example.rst             |  9 +------
 .../userspace-api/media/v4l/capture.c.rst     |  9 +------
 .../media/v4l/colorspaces-defs.rst            |  9 +------
 .../media/v4l/colorspaces-details.rst         |  9 +------
 .../userspace-api/media/v4l/colorspaces.rst   |  9 +------
 .../userspace-api/media/v4l/common-defs.rst   |  9 +------
 .../userspace-api/media/v4l/common.rst        |  9 +------
 .../userspace-api/media/v4l/compat.rst        |  9 +------
 .../userspace-api/media/v4l/control.rst       |  9 +------
 .../userspace-api/media/v4l/crop.rst          |  9 +------
 .../userspace-api/media/v4l/depth-formats.rst |  9 +------
 .../userspace-api/media/v4l/dev-capture.rst   |  9 +------
 .../userspace-api/media/v4l/dev-event.rst     |  9 +------
 .../userspace-api/media/v4l/dev-mem2mem.rst   |  9 +------
 .../userspace-api/media/v4l/dev-meta.rst      |  9 +------
 .../userspace-api/media/v4l/dev-osd.rst       |  9 +------
 .../userspace-api/media/v4l/dev-output.rst    |  9 +------
 .../userspace-api/media/v4l/dev-overlay.rst   |  9 +------
 .../userspace-api/media/v4l/dev-radio.rst     |  9 +------
 .../userspace-api/media/v4l/dev-raw-vbi.rst   |  9 +------
 .../userspace-api/media/v4l/dev-rds.rst       |  9 +------
 .../userspace-api/media/v4l/dev-sdr.rst       |  9 +------
 .../media/v4l/dev-sliced-vbi.rst              |  9 +------
 .../userspace-api/media/v4l/dev-subdev.rst    |  9 +------
 .../userspace-api/media/v4l/dev-touch.rst     |  9 +------
 .../userspace-api/media/v4l/devices.rst       |  9 +------
 .../userspace-api/media/v4l/diff-v4l.rst      |  9 +------
 .../userspace-api/media/v4l/dmabuf.rst        |  9 +------
 .../userspace-api/media/v4l/dv-timings.rst    |  9 +------
 .../media/v4l/ext-ctrls-camera.rst            |  9 +------
 .../media/v4l/ext-ctrls-codec.rst             |  9 +------
 .../media/v4l/ext-ctrls-detect.rst            |  9 +------
 .../userspace-api/media/v4l/ext-ctrls-dv.rst  |  9 +------
 .../media/v4l/ext-ctrls-flash.rst             |  9 +------
 .../media/v4l/ext-ctrls-fm-rx.rst             |  9 +------
 .../media/v4l/ext-ctrls-fm-tx.rst             |  9 +------
 .../media/v4l/ext-ctrls-image-process.rst     |  9 +------
 .../media/v4l/ext-ctrls-image-source.rst      |  9 +------
 .../media/v4l/ext-ctrls-jpeg.rst              |  9 +------
 .../media/v4l/ext-ctrls-rf-tuner.rst          |  9 +------
 .../media/v4l/extended-controls.rst           |  9 +------
 .../userspace-api/media/v4l/field-order.rst   |  9 +------
 .../userspace-api/media/v4l/format.rst        |  9 +------
 .../userspace-api/media/v4l/func-close.rst    |  9 +------
 .../userspace-api/media/v4l/func-ioctl.rst    |  9 +------
 .../userspace-api/media/v4l/func-mmap.rst     |  9 +------
 .../userspace-api/media/v4l/func-munmap.rst   |  9 +------
 .../userspace-api/media/v4l/func-open.rst     |  9 +------
 .../userspace-api/media/v4l/func-poll.rst     |  9 +------
 .../userspace-api/media/v4l/func-read.rst     |  9 +------
 .../userspace-api/media/v4l/func-select.rst   |  9 +------
 .../userspace-api/media/v4l/func-write.rst    |  9 +------
 .../userspace-api/media/v4l/hist-v4l2.rst     |  9 +------
 .../userspace-api/media/v4l/hsv-formats.rst   |  9 +------
 Documentation/userspace-api/media/v4l/io.rst  |  9 +------
 .../media/v4l/libv4l-introduction.rst         |  9 +------
 .../userspace-api/media/v4l/libv4l.rst        |  9 +------
 .../userspace-api/media/v4l/meta-formats.rst  |  9 +------
 .../userspace-api/media/v4l/mmap.rst          |  9 +------
 .../userspace-api/media/v4l/open.rst          |  9 +------
 .../userspace-api/media/v4l/pixfmt-bayer.rst  |  9 +------
 .../media/v4l/pixfmt-compressed.rst           |  9 +------
 .../userspace-api/media/v4l/pixfmt-grey.rst   |  9 +------
 .../media/v4l/pixfmt-indexed.rst              |  9 +------
 .../userspace-api/media/v4l/pixfmt-intro.rst  |  9 +------
 .../userspace-api/media/v4l/pixfmt-inzi.rst   |  9 +------
 .../userspace-api/media/v4l/pixfmt-m420.rst   |  9 +------
 .../media/v4l/pixfmt-meta-d4xx.rst            |  9 +------
 .../media/v4l/pixfmt-meta-intel-ipu3.rst      | 25 +-----------------
 .../media/v4l/pixfmt-meta-uvc.rst             |  9 +------
 .../media/v4l/pixfmt-meta-vivid.rst           | 26 +------------------
 .../media/v4l/pixfmt-meta-vsp1-hgo.rst        |  9 +------
 .../media/v4l/pixfmt-meta-vsp1-hgt.rst        |  9 +------
 .../userspace-api/media/v4l/pixfmt-nv12.rst   |  9 +------
 .../userspace-api/media/v4l/pixfmt-nv12m.rst  |  9 +------
 .../userspace-api/media/v4l/pixfmt-nv12mt.rst |  9 +------
 .../userspace-api/media/v4l/pixfmt-nv16.rst   |  9 +------
 .../userspace-api/media/v4l/pixfmt-nv16m.rst  |  9 +------
 .../userspace-api/media/v4l/pixfmt-nv24.rst   |  9 +------
 .../media/v4l/pixfmt-packed-hsv.rst           |  9 +------
 .../media/v4l/pixfmt-packed-yuv.rst           |  9 +------
 .../media/v4l/pixfmt-reserved.rst             |  9 +------
 .../userspace-api/media/v4l/pixfmt-rgb.rst    |  9 +------
 .../media/v4l/pixfmt-sdr-cs08.rst             |  9 +------
 .../media/v4l/pixfmt-sdr-cs14le.rst           |  9 +------
 .../media/v4l/pixfmt-sdr-cu08.rst             |  9 +------
 .../media/v4l/pixfmt-sdr-cu16le.rst           |  9 +------
 .../media/v4l/pixfmt-sdr-pcu16be.rst          |  9 +------
 .../media/v4l/pixfmt-sdr-pcu18be.rst          |  9 +------
 .../media/v4l/pixfmt-sdr-pcu20be.rst          |  9 +------
 .../media/v4l/pixfmt-sdr-ru12le.rst           |  9 +------
 .../media/v4l/pixfmt-srggb10-ipu3.rst         |  9 +------
 .../media/v4l/pixfmt-srggb10.rst              |  9 +------
 .../media/v4l/pixfmt-srggb10alaw8.rst         |  9 +------
 .../media/v4l/pixfmt-srggb10dpcm8.rst         |  9 +------
 .../media/v4l/pixfmt-srggb10p.rst             |  9 +------
 .../media/v4l/pixfmt-srggb12.rst              |  9 +------
 .../media/v4l/pixfmt-srggb12p.rst             |  9 +------
 .../media/v4l/pixfmt-srggb14.rst              |  9 +------
 .../media/v4l/pixfmt-srggb14p.rst             |  9 +------
 .../media/v4l/pixfmt-srggb16.rst              |  9 +------
 .../userspace-api/media/v4l/pixfmt-srggb8.rst |  9 +------
 .../media/v4l/pixfmt-tch-td08.rst             |  9 +------
 .../media/v4l/pixfmt-tch-td16.rst             |  9 +------
 .../media/v4l/pixfmt-tch-tu08.rst             |  9 +------
 .../media/v4l/pixfmt-tch-tu16.rst             |  9 +------
 .../userspace-api/media/v4l/pixfmt-uv8.rst    |  9 +------
 .../userspace-api/media/v4l/pixfmt-uyvy.rst   |  9 +------
 .../media/v4l/pixfmt-v4l2-mplane.rst          |  9 +------
 .../userspace-api/media/v4l/pixfmt-v4l2.rst   |  9 +------
 .../userspace-api/media/v4l/pixfmt-vyuy.rst   |  9 +------
 .../userspace-api/media/v4l/pixfmt-y10.rst    |  9 +------
 .../userspace-api/media/v4l/pixfmt-y10b.rst   |  9 +------
 .../userspace-api/media/v4l/pixfmt-y10p.rst   |  9 +------
 .../userspace-api/media/v4l/pixfmt-y12.rst    |  9 +------
 .../userspace-api/media/v4l/pixfmt-y12i.rst   |  9 +------
 .../userspace-api/media/v4l/pixfmt-y14.rst    |  9 +------
 .../userspace-api/media/v4l/pixfmt-y16-be.rst |  9 +------
 .../userspace-api/media/v4l/pixfmt-y16.rst    |  9 +------
 .../userspace-api/media/v4l/pixfmt-y41p.rst   |  9 +------
 .../userspace-api/media/v4l/pixfmt-y8i.rst    |  9 +------
 .../userspace-api/media/v4l/pixfmt-yuv410.rst |  9 +------
 .../media/v4l/pixfmt-yuv411p.rst              |  9 +------
 .../userspace-api/media/v4l/pixfmt-yuv420.rst |  9 +------
 .../media/v4l/pixfmt-yuv420m.rst              |  9 +------
 .../media/v4l/pixfmt-yuv422m.rst              |  9 +------
 .../media/v4l/pixfmt-yuv422p.rst              |  9 +------
 .../media/v4l/pixfmt-yuv444m.rst              |  9 +------
 .../userspace-api/media/v4l/pixfmt-yuyv.rst   |  9 +------
 .../userspace-api/media/v4l/pixfmt-yvyu.rst   |  9 +------
 .../userspace-api/media/v4l/pixfmt-z16.rst    |  9 +------
 .../userspace-api/media/v4l/pixfmt.rst        |  9 +------
 .../userspace-api/media/v4l/planar-apis.rst   |  9 +------
 .../userspace-api/media/v4l/querycap.rst      |  9 +------
 Documentation/userspace-api/media/v4l/rw.rst  |  9 +------
 .../userspace-api/media/v4l/sdr-formats.rst   |  9 +------
 .../media/v4l/selection-api-configuration.rst |  9 +------
 .../media/v4l/selection-api-examples.rst      |  9 +------
 .../media/v4l/selection-api-intro.rst         |  9 +------
 .../media/v4l/selection-api-targets.rst       |  9 +------
 .../media/v4l/selection-api-vs-crop-api.rst   |  9 +------
 .../userspace-api/media/v4l/selection-api.rst |  9 +------
 .../media/v4l/selections-common.rst           |  9 +------
 .../userspace-api/media/v4l/standard.rst      |  9 +------
 .../userspace-api/media/v4l/streaming-par.rst |  9 +------
 .../media/v4l/subdev-formats.rst              |  9 +------
 .../userspace-api/media/v4l/tch-formats.rst   |  9 +------
 .../userspace-api/media/v4l/tuner.rst         |  9 +------
 .../userspace-api/media/v4l/user-func.rst     |  9 +------
 .../userspace-api/media/v4l/userp.rst         |  9 +------
 .../media/v4l/v4l2-selection-flags.rst        |  9 +------
 .../media/v4l/v4l2-selection-targets.rst      |  9 +------
 .../userspace-api/media/v4l/v4l2.rst          |  9 +------
 .../media/v4l/v4l2grab-example.rst            |  9 +------
 .../userspace-api/media/v4l/v4l2grab.c.rst    |  9 +------
 .../userspace-api/media/v4l/video.rst         |  9 +------
 .../userspace-api/media/v4l/videodev.rst      |  9 +------
 .../media/v4l/vidioc-create-bufs.rst          |  9 +------
 .../media/v4l/vidioc-cropcap.rst              |  9 +------
 .../media/v4l/vidioc-dbg-g-chip-info.rst      |  9 +------
 .../media/v4l/vidioc-dbg-g-register.rst       |  9 +------
 .../media/v4l/vidioc-decoder-cmd.rst          |  9 +------
 .../media/v4l/vidioc-dqevent.rst              |  9 +------
 .../media/v4l/vidioc-dv-timings-cap.rst       |  9 +------
 .../media/v4l/vidioc-encoder-cmd.rst          |  9 +------
 .../media/v4l/vidioc-enum-dv-timings.rst      |  9 +------
 .../media/v4l/vidioc-enum-fmt.rst             |  9 +------
 .../media/v4l/vidioc-enum-frameintervals.rst  |  9 +------
 .../media/v4l/vidioc-enum-framesizes.rst      |  9 +------
 .../media/v4l/vidioc-enum-freq-bands.rst      |  9 +------
 .../media/v4l/vidioc-enumaudio.rst            |  9 +------
 .../media/v4l/vidioc-enumaudioout.rst         |  9 +------
 .../media/v4l/vidioc-enuminput.rst            |  9 +------
 .../media/v4l/vidioc-enumoutput.rst           |  9 +------
 .../media/v4l/vidioc-enumstd.rst              |  9 +------
 .../userspace-api/media/v4l/vidioc-expbuf.rst |  9 +------
 .../media/v4l/vidioc-g-audio.rst              |  9 +------
 .../media/v4l/vidioc-g-audioout.rst           |  9 +------
 .../userspace-api/media/v4l/vidioc-g-crop.rst |  9 +------
 .../userspace-api/media/v4l/vidioc-g-ctrl.rst |  9 +------
 .../media/v4l/vidioc-g-dv-timings.rst         |  9 +------
 .../userspace-api/media/v4l/vidioc-g-edid.rst |  9 +------
 .../media/v4l/vidioc-g-enc-index.rst          |  9 +------
 .../media/v4l/vidioc-g-ext-ctrls.rst          |  9 +------
 .../userspace-api/media/v4l/vidioc-g-fbuf.rst |  9 +------
 .../userspace-api/media/v4l/vidioc-g-fmt.rst  |  9 +------
 .../media/v4l/vidioc-g-frequency.rst          |  9 +------
 .../media/v4l/vidioc-g-input.rst              |  9 +------
 .../media/v4l/vidioc-g-jpegcomp.rst           |  9 +------
 .../media/v4l/vidioc-g-modulator.rst          |  9 +------
 .../media/v4l/vidioc-g-output.rst             |  9 +------
 .../userspace-api/media/v4l/vidioc-g-parm.rst |  9 +------
 .../media/v4l/vidioc-g-priority.rst           |  9 +------
 .../media/v4l/vidioc-g-selection.rst          |  9 +------
 .../media/v4l/vidioc-g-sliced-vbi-cap.rst     |  9 +------
 .../userspace-api/media/v4l/vidioc-g-std.rst  |  9 +------
 .../media/v4l/vidioc-g-tuner.rst              |  9 +------
 .../media/v4l/vidioc-log-status.rst           |  9 +------
 .../media/v4l/vidioc-overlay.rst              |  9 +------
 .../media/v4l/vidioc-prepare-buf.rst          |  9 +------
 .../userspace-api/media/v4l/vidioc-qbuf.rst   |  9 +------
 .../media/v4l/vidioc-query-dv-timings.rst     |  9 +------
 .../media/v4l/vidioc-querybuf.rst             |  9 +------
 .../media/v4l/vidioc-querycap.rst             |  9 +------
 .../media/v4l/vidioc-queryctrl.rst            |  9 +------
 .../media/v4l/vidioc-querystd.rst             |  9 +------
 .../media/v4l/vidioc-reqbufs.rst              |  9 +------
 .../media/v4l/vidioc-s-hw-freq-seek.rst       |  9 +------
 .../media/v4l/vidioc-streamon.rst             |  9 +------
 .../v4l/vidioc-subdev-enum-frame-interval.rst |  9 +------
 .../v4l/vidioc-subdev-enum-frame-size.rst     |  9 +------
 .../v4l/vidioc-subdev-enum-mbus-code.rst      |  9 +------
 .../media/v4l/vidioc-subdev-g-crop.rst        |  9 +------
 .../media/v4l/vidioc-subdev-g-fmt.rst         |  9 +------
 .../v4l/vidioc-subdev-g-frame-interval.rst    |  9 +------
 .../media/v4l/vidioc-subdev-g-selection.rst   |  9 +------
 .../media/v4l/vidioc-subdev-querycap.rst      |  9 +------
 .../media/v4l/vidioc-subscribe-event.rst      |  9 +------
 .../userspace-api/media/v4l/yuv-formats.rst   |  9 +------
 420 files changed, 420 insertions(+), 3507 deletions(-)

diff --git a/Documentation/userspace-api/media/cec/cec-api.rst b/Documentation/userspace-api/media/cec/cec-api.rst
index 871db54dfd24..4d27f1d6137b 100644
--- a/Documentation/userspace-api/media/cec/cec-api.rst
+++ b/Documentation/userspace-api/media/cec/cec-api.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. include:: <isonum.txt>
 
diff --git a/Documentation/userspace-api/media/cec/cec-func-close.rst b/Documentation/userspace-api/media/cec/cec-func-close.rst
index b89e06a43dad..f610d8ed1727 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _cec-func-close:
 
diff --git a/Documentation/userspace-api/media/cec/cec-func-ioctl.rst b/Documentation/userspace-api/media/cec/cec-func-ioctl.rst
index d16a479aacb1..049148d7aca8 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _cec-func-ioctl:
 
diff --git a/Documentation/userspace-api/media/cec/cec-func-open.rst b/Documentation/userspace-api/media/cec/cec-func-open.rst
index 67fd021556b2..19242cacbd51 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _cec-func-open:
 
diff --git a/Documentation/userspace-api/media/cec/cec-func-poll.rst b/Documentation/userspace-api/media/cec/cec-func-poll.rst
index ed3652d9bf17..fb6e8482ba14 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _cec-func-poll:
 
diff --git a/Documentation/userspace-api/media/cec/cec-funcs.rst b/Documentation/userspace-api/media/cec/cec-funcs.rst
index 88966b5175d2..722c0a308def 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _cec-user-func:
 
diff --git a/Documentation/userspace-api/media/cec/cec-header.rst b/Documentation/userspace-api/media/cec/cec-header.rst
index 24a83b0c35af..0d650a229289 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _cec_header:
 
diff --git a/Documentation/userspace-api/media/cec/cec-intro.rst b/Documentation/userspace-api/media/cec/cec-intro.rst
index a4db82388202..be653b67f490 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _cec-intro:
 
diff --git a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
index 94e46a11d68d..10807e5755f2 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _CEC_ADAP_G_CAPS:
 
diff --git a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-addrs.rst b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-addrs.rst
index 8ba3511c88b8..81d3d1141687 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _CEC_ADAP_LOG_ADDRS:
 .. _CEC_ADAP_G_LOG_ADDRS:
diff --git a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-phys-addr.rst b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-phys-addr.rst
index ce8f64c3e060..3158398d2221 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _CEC_ADAP_PHYS_ADDR:
 .. _CEC_ADAP_G_PHYS_ADDR:
diff --git a/Documentation/userspace-api/media/cec/cec-ioc-dqevent.rst b/Documentation/userspace-api/media/cec/cec-ioc-dqevent.rst
index 4a535fb64b4b..22ad48e9270b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _CEC_DQEVENT:
 
diff --git a/Documentation/userspace-api/media/cec/cec-ioc-g-mode.rst b/Documentation/userspace-api/media/cec/cec-ioc-g-mode.rst
index 2d3227e80b4f..9ef811f34d7a 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _CEC_MODE:
 .. _CEC_G_MODE:
diff --git a/Documentation/userspace-api/media/cec/cec-ioc-receive.rst b/Documentation/userspace-api/media/cec/cec-ioc-receive.rst
index e456b2bc92a1..2a627db3d1a7 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _CEC_TRANSMIT:
 .. _CEC_RECEIVE:
diff --git a/Documentation/userspace-api/media/cec/cec-pin-error-inj.rst b/Documentation/userspace-api/media/cec/cec-pin-error-inj.rst
index 78632199324d..748959c83767 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 CEC Pin Framework Error Injection
 =================================
diff --git a/Documentation/userspace-api/media/dvb/audio-bilingual-channel-select.rst b/Documentation/userspace-api/media/dvb/audio-bilingual-channel-select.rst
index 6841233f3fee..270117b9168d 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _AUDIO_BILINGUAL_CHANNEL_SELECT:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-channel-select.rst b/Documentation/userspace-api/media/dvb/audio-channel-select.rst
index 18e880e7eab4..8d12711d1ef9 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _AUDIO_CHANNEL_SELECT:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-clear-buffer.rst b/Documentation/userspace-api/media/dvb/audio-clear-buffer.rst
index 19f2ed752ce2..c1bf75d84cbf 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _AUDIO_CLEAR_BUFFER:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-continue.rst b/Documentation/userspace-api/media/dvb/audio-continue.rst
index b9a2b1e608b6..e048135642b3 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _AUDIO_CONTINUE:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-fclose.rst b/Documentation/userspace-api/media/dvb/audio-fclose.rst
index 448471d2f570..79dbaa7800c3 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _audio_fclose:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-fopen.rst b/Documentation/userspace-api/media/dvb/audio-fopen.rst
index f7ae94378f92..f36750e0bcc6 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _audio_fopen:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-fwrite.rst b/Documentation/userspace-api/media/dvb/audio-fwrite.rst
index 1482636f9b1a..6a9ef0195ca8 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _audio_fwrite:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-get-capabilities.rst b/Documentation/userspace-api/media/dvb/audio-get-capabilities.rst
index 4e70d82969ad..b4bfc8c9f875 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _AUDIO_GET_CAPABILITIES:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-get-status.rst b/Documentation/userspace-api/media/dvb/audio-get-status.rst
index 5a5180d642d4..e04c9f50065b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _AUDIO_GET_STATUS:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-pause.rst b/Documentation/userspace-api/media/dvb/audio-pause.rst
index 3e9fe06d3a0f..a97bd2562fb9 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _AUDIO_PAUSE:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-play.rst b/Documentation/userspace-api/media/dvb/audio-play.rst
index 388a581a19f2..2ff4f6556848 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _AUDIO_PLAY:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-select-source.rst b/Documentation/userspace-api/media/dvb/audio-select-source.rst
index 1ce64507de93..edf270a16c20 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _AUDIO_SELECT_SOURCE:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-set-av-sync.rst b/Documentation/userspace-api/media/dvb/audio-set-av-sync.rst
index 3a0400dcfae4..13020595c3a9 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _AUDIO_SET_AV_SYNC:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-set-bypass-mode.rst b/Documentation/userspace-api/media/dvb/audio-set-bypass-mode.rst
index 0d2f23cc2f16..b8053f3f1f05 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _AUDIO_SET_BYPASS_MODE:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-set-id.rst b/Documentation/userspace-api/media/dvb/audio-set-id.rst
index 83fc1217fda0..e74bee2e5093 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _AUDIO_SET_ID:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-set-mixer.rst b/Documentation/userspace-api/media/dvb/audio-set-mixer.rst
index 52bfc3af79dc..22ea9b62b8c1 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _AUDIO_SET_MIXER:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-set-mute.rst b/Documentation/userspace-api/media/dvb/audio-set-mute.rst
index 8f3a8332cebc..c7ba5ea08ceb 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _AUDIO_SET_MUTE:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-set-streamtype.rst b/Documentation/userspace-api/media/dvb/audio-set-streamtype.rst
index c22bd247f03d..a3c5cb132777 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _AUDIO_SET_STREAMTYPE:
 
diff --git a/Documentation/userspace-api/media/dvb/audio-stop.rst b/Documentation/userspace-api/media/dvb/audio-stop.rst
index 291b6a42efac..1d1aaae7e894 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _AUDIO_STOP:
 
diff --git a/Documentation/userspace-api/media/dvb/audio.rst b/Documentation/userspace-api/media/dvb/audio.rst
index e137c151335d..b403e70bcb68 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _dvb_audio:
 
diff --git a/Documentation/userspace-api/media/dvb/audio_data_types.rst b/Documentation/userspace-api/media/dvb/audio_data_types.rst
index effe265b12d5..b5587d4de288 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _audio_data_types:
 
diff --git a/Documentation/userspace-api/media/dvb/audio_function_calls.rst b/Documentation/userspace-api/media/dvb/audio_function_calls.rst
index be90a828fe29..953f02060dc7 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _audio_function_calls:
 
diff --git a/Documentation/userspace-api/media/dvb/ca-fclose.rst b/Documentation/userspace-api/media/dvb/ca-fclose.rst
index cedfb7ee6a01..ff2b2a92455e 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _ca_fclose:
 
diff --git a/Documentation/userspace-api/media/dvb/ca-fopen.rst b/Documentation/userspace-api/media/dvb/ca-fopen.rst
index aa0fde1739a8..53df86c852c1 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _ca_fopen:
 
diff --git a/Documentation/userspace-api/media/dvb/ca-get-cap.rst b/Documentation/userspace-api/media/dvb/ca-get-cap.rst
index b808d0592371..d82f5cc17c91 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _CA_GET_CAP:
 
diff --git a/Documentation/userspace-api/media/dvb/ca-get-descr-info.rst b/Documentation/userspace-api/media/dvb/ca-get-descr-info.rst
index 396cc66a8243..0390a5ada9b5 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _CA_GET_DESCR_INFO:
 
diff --git a/Documentation/userspace-api/media/dvb/ca-get-msg.rst b/Documentation/userspace-api/media/dvb/ca-get-msg.rst
index 995f461d6879..4591c6bc212a 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _CA_GET_MSG:
 
diff --git a/Documentation/userspace-api/media/dvb/ca-get-slot-info.rst b/Documentation/userspace-api/media/dvb/ca-get-slot-info.rst
index c65987ff9cb3..61e3c5d5f18f 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _CA_GET_SLOT_INFO:
 
diff --git a/Documentation/userspace-api/media/dvb/ca-reset.rst b/Documentation/userspace-api/media/dvb/ca-reset.rst
index 116a5a8eeb5d..89107a972f42 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _CA_RESET:
 
diff --git a/Documentation/userspace-api/media/dvb/ca-send-msg.rst b/Documentation/userspace-api/media/dvb/ca-send-msg.rst
index 716d88e0fdc5..f9457865aae1 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _CA_SEND_MSG:
 
diff --git a/Documentation/userspace-api/media/dvb/ca-set-descr.rst b/Documentation/userspace-api/media/dvb/ca-set-descr.rst
index 2c57371675e2..664d86810ea2 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _CA_SET_DESCR:
 
diff --git a/Documentation/userspace-api/media/dvb/ca.rst b/Documentation/userspace-api/media/dvb/ca.rst
index 643b7c414943..5b483ef20a61 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _dvb_ca:
 
diff --git a/Documentation/userspace-api/media/dvb/ca_data_types.rst b/Documentation/userspace-api/media/dvb/ca_data_types.rst
index 20e2b552144f..00f3c11b93d6 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _ca_data_types:
 
diff --git a/Documentation/userspace-api/media/dvb/ca_function_calls.rst b/Documentation/userspace-api/media/dvb/ca_function_calls.rst
index b8aceb1895b6..0c22ebcffa39 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _ca_function_calls:
 
diff --git a/Documentation/userspace-api/media/dvb/demux.rst b/Documentation/userspace-api/media/dvb/demux.rst
index 00397b075e0f..f10a5224006c 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _dvb_demux:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-add-pid.rst b/Documentation/userspace-api/media/dvb/dmx-add-pid.rst
index e309cd56fdf0..eee3a4bbb12d 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _DMX_ADD_PID:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-expbuf.rst b/Documentation/userspace-api/media/dvb/dmx-expbuf.rst
index f76db8ce3cfa..b90069d60b09 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _DMX_EXPBUF:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-fclose.rst b/Documentation/userspace-api/media/dvb/dmx-fclose.rst
index e93bc60da508..5be75834820b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _dmx_fclose:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-fopen.rst b/Documentation/userspace-api/media/dvb/dmx-fopen.rst
index ea988714558e..82fadb83801d 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _dmx_fopen:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-fread.rst b/Documentation/userspace-api/media/dvb/dmx-fread.rst
index 25501be818f8..af2f83597724 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _dmx_fread:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-fwrite.rst b/Documentation/userspace-api/media/dvb/dmx-fwrite.rst
index 4400f4ef8c65..942857698533 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _dmx_fwrite:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-get-pes-pids.rst b/Documentation/userspace-api/media/dvb/dmx-get-pes-pids.rst
index e1873e3fdc01..d8f19b9fdfcd 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _DMX_GET_PES_PIDS:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-get-stc.rst b/Documentation/userspace-api/media/dvb/dmx-get-stc.rst
index 026a884edb0a..26e6d7c498a8 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _DMX_GET_STC:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-mmap.rst b/Documentation/userspace-api/media/dvb/dmx-mmap.rst
index 828ba9df73e2..c636cb805a64 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _dmx-mmap:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-munmap.rst b/Documentation/userspace-api/media/dvb/dmx-munmap.rst
index 905fdd585a86..d36803ea1d5d 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _dmx-munmap:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-qbuf.rst b/Documentation/userspace-api/media/dvb/dmx-qbuf.rst
index 2c4657c2c86d..4f5fd0d1f28d 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _DMX_QBUF:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-querybuf.rst b/Documentation/userspace-api/media/dvb/dmx-querybuf.rst
index 6e234daf1c44..de23547236d4 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _DMX_QUERYBUF:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-remove-pid.rst b/Documentation/userspace-api/media/dvb/dmx-remove-pid.rst
index dee553a48b63..1b5780312492 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _DMX_REMOVE_PID:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-reqbufs.rst b/Documentation/userspace-api/media/dvb/dmx-reqbufs.rst
index 9b9be45d2b0b..704f8f4186ef 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _DMX_REQBUFS:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-set-buffer-size.rst b/Documentation/userspace-api/media/dvb/dmx-set-buffer-size.rst
index 7c91da1da4be..9c7732e434a3 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _DMX_SET_BUFFER_SIZE:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-set-filter.rst b/Documentation/userspace-api/media/dvb/dmx-set-filter.rst
index cb3333349bd0..480ee6d9df4a 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _DMX_SET_FILTER:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-set-pes-filter.rst b/Documentation/userspace-api/media/dvb/dmx-set-pes-filter.rst
index 26da56947652..6c6b405e78cd 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _DMX_SET_PES_FILTER:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-start.rst b/Documentation/userspace-api/media/dvb/dmx-start.rst
index a1d35f01fc95..eb565378f425 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _DMX_START:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx-stop.rst b/Documentation/userspace-api/media/dvb/dmx-stop.rst
index 5e6e805010d0..1a7c91b2780e 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _DMX_STOP:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx_fcalls.rst b/Documentation/userspace-api/media/dvb/dmx_fcalls.rst
index 04e150f00f84..6371c2349628 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _dmx_fcalls:
 
diff --git a/Documentation/userspace-api/media/dvb/dmx_types.rst b/Documentation/userspace-api/media/dvb/dmx_types.rst
index 635b8fd363be..6dcfc379d191 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _dmx_types:
 
diff --git a/Documentation/userspace-api/media/dvb/dvb-fe-read-status.rst b/Documentation/userspace-api/media/dvb/dvb-fe-read-status.rst
index 5d6a7735a9d1..484397603a15 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _dvb-fe-read-status:
 
diff --git a/Documentation/userspace-api/media/dvb/dvb-frontend-event.rst b/Documentation/userspace-api/media/dvb/dvb-frontend-event.rst
index 7f5e56cf75cb..9a054ca11951 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. c:type:: dvb_frontend_event
 
diff --git a/Documentation/userspace-api/media/dvb/dvb-frontend-parameters.rst b/Documentation/userspace-api/media/dvb/dvb-frontend-parameters.rst
index 83b1bcc6ef54..fe558757763d 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. c:type:: dvb_frontend_parameters
 
diff --git a/Documentation/userspace-api/media/dvb/dvbapi.rst b/Documentation/userspace-api/media/dvb/dvbapi.rst
index 74b16ab3fd94..36638f4449ef 100644
--- a/Documentation/userspace-api/media/dvb/dvbapi.rst
+++ b/Documentation/userspace-api/media/dvb/dvbapi.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. include:: <isonum.txt>
 
diff --git a/Documentation/userspace-api/media/dvb/dvbproperty.rst b/Documentation/userspace-api/media/dvb/dvbproperty.rst
index 1716733d24ba..5d4135e0db2c 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _frontend-properties:
 
diff --git a/Documentation/userspace-api/media/dvb/examples.rst b/Documentation/userspace-api/media/dvb/examples.rst
index bd0adde86b96..30778be8cd3b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _dvb_examples:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-bandwidth-t.rst b/Documentation/userspace-api/media/dvb/fe-bandwidth-t.rst
index 6293287af67c..72d935df1e32 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 ******************
 Frontend bandwidth
diff --git a/Documentation/userspace-api/media/dvb/fe-diseqc-recv-slave-reply.rst b/Documentation/userspace-api/media/dvb/fe-diseqc-recv-slave-reply.rst
index b520974e8c46..b482abbfcefe 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _FE_DISEQC_RECV_SLAVE_REPLY:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-diseqc-reset-overload.rst b/Documentation/userspace-api/media/dvb/fe-diseqc-reset-overload.rst
index c59af46b8e87..43f70640ea5b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _FE_DISEQC_RESET_OVERLOAD:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-diseqc-send-burst.rst b/Documentation/userspace-api/media/dvb/fe-diseqc-send-burst.rst
index 19b51d0550f7..168c9972d0e7 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _FE_DISEQC_SEND_BURST:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-diseqc-send-master-cmd.rst b/Documentation/userspace-api/media/dvb/fe-diseqc-send-master-cmd.rst
index f75513d018c8..30390df0bb7c 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _FE_DISEQC_SEND_MASTER_CMD:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-dishnetwork-send-legacy-cmd.rst b/Documentation/userspace-api/media/dvb/fe-dishnetwork-send-legacy-cmd.rst
index ea66f72fe5f8..7c3de7025751 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _FE_DISHNETWORK_SEND_LEGACY_CMD:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-enable-high-lnb-voltage.rst b/Documentation/userspace-api/media/dvb/fe-enable-high-lnb-voltage.rst
index 9bdf1e898ddc..ff1c9f299153 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _FE_ENABLE_HIGH_LNB_VOLTAGE:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-get-event.rst b/Documentation/userspace-api/media/dvb/fe-get-event.rst
index 19df41dca238..e33a4cdcd4af 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _FE_GET_EVENT:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-get-frontend.rst b/Documentation/userspace-api/media/dvb/fe-get-frontend.rst
index 7968adc8e982..8e2c4ef97132 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _FE_GET_FRONTEND:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-get-info.rst b/Documentation/userspace-api/media/dvb/fe-get-info.rst
index 80d9f8195ac4..021b431787bf 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _FE_GET_INFO:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-get-property.rst b/Documentation/userspace-api/media/dvb/fe-get-property.rst
index 088d4e319405..5831fe32e789 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _FE_GET_PROPERTY:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-read-ber.rst b/Documentation/userspace-api/media/dvb/fe-read-ber.rst
index d0a706ac9011..29e981deb911 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _FE_READ_BER:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-read-signal-strength.rst b/Documentation/userspace-api/media/dvb/fe-read-signal-strength.rst
index df79837de47d..9b9a740f9420 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _FE_READ_SIGNAL_STRENGTH:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-read-snr.rst b/Documentation/userspace-api/media/dvb/fe-read-snr.rst
index e56147a40e23..52c66d38530a 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _FE_READ_SNR:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-read-status.rst b/Documentation/userspace-api/media/dvb/fe-read-status.rst
index cf781d463a20..add29e3a41ed 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _FE_READ_STATUS:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-read-uncorrected-blocks.rst b/Documentation/userspace-api/media/dvb/fe-read-uncorrected-blocks.rst
index d042e8c86930..18f657d623b6 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _FE_READ_UNCORRECTED_BLOCKS:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-set-frontend-tune-mode.rst b/Documentation/userspace-api/media/dvb/fe-set-frontend-tune-mode.rst
index 8e059967f49c..2590fee47861 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _FE_SET_FRONTEND_TUNE_MODE:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-set-frontend.rst b/Documentation/userspace-api/media/dvb/fe-set-frontend.rst
index 960c95cb18a0..47a97157f439 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _FE_SET_FRONTEND:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-set-tone.rst b/Documentation/userspace-api/media/dvb/fe-set-tone.rst
index 5726a20c7991..1ff2e75855f8 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _FE_SET_TONE:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-set-voltage.rst b/Documentation/userspace-api/media/dvb/fe-set-voltage.rst
index f3191808f4fd..a62ca6ed5851 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _FE_SET_VOLTAGE:
 
diff --git a/Documentation/userspace-api/media/dvb/fe-type-t.rst b/Documentation/userspace-api/media/dvb/fe-type-t.rst
index 1617a8cc9045..0812343a4678 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 *************
 Frontend type
diff --git a/Documentation/userspace-api/media/dvb/fe_property_parameters.rst b/Documentation/userspace-api/media/dvb/fe_property_parameters.rst
index 3f4ced2800e3..a5c30a612b01 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _fe_property_parameters:
 
diff --git a/Documentation/userspace-api/media/dvb/frontend-header.rst b/Documentation/userspace-api/media/dvb/frontend-header.rst
index cf8e515e5e1f..bba93a369d5e 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 Frontend uAPI data types
 ========================
diff --git a/Documentation/userspace-api/media/dvb/frontend-property-cable-systems.rst b/Documentation/userspace-api/media/dvb/frontend-property-cable-systems.rst
index 56657a6ec6ff..fcc7b2a25231 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _frontend-property-cable-systems:
 
diff --git a/Documentation/userspace-api/media/dvb/frontend-property-satellite-systems.rst b/Documentation/userspace-api/media/dvb/frontend-property-satellite-systems.rst
index e64fd625c476..4119b3e6568f 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _frontend-property-satellite-systems:
 
diff --git a/Documentation/userspace-api/media/dvb/frontend-property-terrestrial-systems.rst b/Documentation/userspace-api/media/dvb/frontend-property-terrestrial-systems.rst
index 1079522b2425..331ecc45970d 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _frontend-property-terrestrial-systems:
 
diff --git a/Documentation/userspace-api/media/dvb/frontend-stat-properties.rst b/Documentation/userspace-api/media/dvb/frontend-stat-properties.rst
index ae6ed5128deb..1a6cda36fc65 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _frontend-stat-properties:
 
diff --git a/Documentation/userspace-api/media/dvb/frontend.rst b/Documentation/userspace-api/media/dvb/frontend.rst
index 41ad519ca502..6c4cb4b3d2e2 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _dvb_frontend:
 
diff --git a/Documentation/userspace-api/media/dvb/frontend_f_close.rst b/Documentation/userspace-api/media/dvb/frontend_f_close.rst
index 582e19a83c1a..612408fbd0b5 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _frontend_f_close:
 
diff --git a/Documentation/userspace-api/media/dvb/frontend_f_open.rst b/Documentation/userspace-api/media/dvb/frontend_f_open.rst
index 0be3b249d33b..c6a5e20b19eb 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _frontend_f_open:
 
diff --git a/Documentation/userspace-api/media/dvb/frontend_fcalls.rst b/Documentation/userspace-api/media/dvb/frontend_fcalls.rst
index 2b5e7a4dba9e..3caa40258ebb 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _frontend_fcalls:
 
diff --git a/Documentation/userspace-api/media/dvb/frontend_legacy_api.rst b/Documentation/userspace-api/media/dvb/frontend_legacy_api.rst
index 1bd804f9b364..a50b8e0eb622 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _frontend_legacy_types:
 
diff --git a/Documentation/userspace-api/media/dvb/frontend_legacy_dvbv3_api.rst b/Documentation/userspace-api/media/dvb/frontend_legacy_dvbv3_api.rst
index 29ad0f9b90a4..de1f72c43ebd 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _frontend_legacy_dvbv3_api:
 
diff --git a/Documentation/userspace-api/media/dvb/headers.rst b/Documentation/userspace-api/media/dvb/headers.rst
index ffd8f432484a..67898df68fd7 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 ****************************
 Digital TV uAPI header files
diff --git a/Documentation/userspace-api/media/dvb/intro.rst b/Documentation/userspace-api/media/dvb/intro.rst
index f1235ef4599e..06e61cb1428a 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _dvb_introdution:
 
diff --git a/Documentation/userspace-api/media/dvb/legacy_dvb_apis.rst b/Documentation/userspace-api/media/dvb/legacy_dvb_apis.rst
index 17c3b062afb3..72a2baf4129d 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _legacy_dvb_apis:
 
diff --git a/Documentation/userspace-api/media/dvb/net-add-if.rst b/Documentation/userspace-api/media/dvb/net-add-if.rst
index e75ec4d80a08..edf361253891 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _NET_ADD_IF:
 
diff --git a/Documentation/userspace-api/media/dvb/net-get-if.rst b/Documentation/userspace-api/media/dvb/net-get-if.rst
index c5421d9a8c0b..c905480879dd 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _NET_GET_IF:
 
diff --git a/Documentation/userspace-api/media/dvb/net-remove-if.rst b/Documentation/userspace-api/media/dvb/net-remove-if.rst
index d530559f66f1..e601bfd79341 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _NET_REMOVE_IF:
 
diff --git a/Documentation/userspace-api/media/dvb/net-types.rst b/Documentation/userspace-api/media/dvb/net-types.rst
index 94323cffe8af..f7c2909786c9 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _net_types:
 
diff --git a/Documentation/userspace-api/media/dvb/net.rst b/Documentation/userspace-api/media/dvb/net.rst
index 084f33d1ba28..e4fb2e1b6da8 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _net:
 
diff --git a/Documentation/userspace-api/media/dvb/query-dvb-frontend-info.rst b/Documentation/userspace-api/media/dvb/query-dvb-frontend-info.rst
index d854ccf42ccf..6cb80b31ea7a 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _query-dvb-frontend-info:
 
diff --git a/Documentation/userspace-api/media/dvb/video-clear-buffer.rst b/Documentation/userspace-api/media/dvb/video-clear-buffer.rst
index ba7a13302862..5f3c54b67d0b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_CLEAR_BUFFER:
 
diff --git a/Documentation/userspace-api/media/dvb/video-command.rst b/Documentation/userspace-api/media/dvb/video-command.rst
index d96d764d0eef..b53b7730f68c 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_COMMAND:
 
diff --git a/Documentation/userspace-api/media/dvb/video-continue.rst b/Documentation/userspace-api/media/dvb/video-continue.rst
index bb18514ac5e9..791537699dbb 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_CONTINUE:
 
diff --git a/Documentation/userspace-api/media/dvb/video-fast-forward.rst b/Documentation/userspace-api/media/dvb/video-fast-forward.rst
index 1f6ec89574d1..52a730f9025d 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_FAST_FORWARD:
 
diff --git a/Documentation/userspace-api/media/dvb/video-fclose.rst b/Documentation/userspace-api/media/dvb/video-fclose.rst
index f9d2a8ebe4a4..6510fe6c6ce2 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _video_fclose:
 
diff --git a/Documentation/userspace-api/media/dvb/video-fopen.rst b/Documentation/userspace-api/media/dvb/video-fopen.rst
index a418cf6d772e..410590b15599 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _video_fopen:
 
diff --git a/Documentation/userspace-api/media/dvb/video-freeze.rst b/Documentation/userspace-api/media/dvb/video-freeze.rst
index 46f287faa7fe..3c0eaa863a67 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_FREEZE:
 
diff --git a/Documentation/userspace-api/media/dvb/video-fwrite.rst b/Documentation/userspace-api/media/dvb/video-fwrite.rst
index 08dfafa9c6a1..ccc59bf3de82 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _video_fwrite:
 
diff --git a/Documentation/userspace-api/media/dvb/video-get-capabilities.rst b/Documentation/userspace-api/media/dvb/video-get-capabilities.rst
index f6f19df5a3b4..7d5275d8b7db 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_GET_CAPABILITIES:
 
diff --git a/Documentation/userspace-api/media/dvb/video-get-event.rst b/Documentation/userspace-api/media/dvb/video-get-event.rst
index 6db8e6337c4f..2ae761031fd5 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_GET_EVENT:
 
diff --git a/Documentation/userspace-api/media/dvb/video-get-frame-count.rst b/Documentation/userspace-api/media/dvb/video-get-frame-count.rst
index 4152a42daeb3..cd9c91b64e67 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_GET_FRAME_COUNT:
 
diff --git a/Documentation/userspace-api/media/dvb/video-get-pts.rst b/Documentation/userspace-api/media/dvb/video-get-pts.rst
index f957df792ae1..9636426a5d13 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_GET_PTS:
 
diff --git a/Documentation/userspace-api/media/dvb/video-get-size.rst b/Documentation/userspace-api/media/dvb/video-get-size.rst
index 376745550eb5..b716b9d5d49f 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_GET_SIZE:
 
diff --git a/Documentation/userspace-api/media/dvb/video-get-status.rst b/Documentation/userspace-api/media/dvb/video-get-status.rst
index d0172593e557..d5b98407317d 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_GET_STATUS:
 
diff --git a/Documentation/userspace-api/media/dvb/video-play.rst b/Documentation/userspace-api/media/dvb/video-play.rst
index 2b6b4e93bd93..cdea615cba84 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_PLAY:
 
diff --git a/Documentation/userspace-api/media/dvb/video-select-source.rst b/Documentation/userspace-api/media/dvb/video-select-source.rst
index 504f768da00c..8c220fd98fde 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_SELECT_SOURCE:
 
diff --git a/Documentation/userspace-api/media/dvb/video-set-blank.rst b/Documentation/userspace-api/media/dvb/video-set-blank.rst
index a2608df94d3e..68078a968fa9 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_SET_BLANK:
 
diff --git a/Documentation/userspace-api/media/dvb/video-set-display-format.rst b/Documentation/userspace-api/media/dvb/video-set-display-format.rst
index c587b3d15e30..ef90dea556d3 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_SET_DISPLAY_FORMAT:
 
diff --git a/Documentation/userspace-api/media/dvb/video-set-format.rst b/Documentation/userspace-api/media/dvb/video-set-format.rst
index ced74edb74eb..df6b81d98bc7 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_SET_FORMAT:
 
diff --git a/Documentation/userspace-api/media/dvb/video-set-streamtype.rst b/Documentation/userspace-api/media/dvb/video-set-streamtype.rst
index 1729bc04e4f7..581bc600a907 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_SET_STREAMTYPE:
 
diff --git a/Documentation/userspace-api/media/dvb/video-slowmotion.rst b/Documentation/userspace-api/media/dvb/video-slowmotion.rst
index b8cfba7bbfb3..6487d139b3da 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_SLOWMOTION:
 
diff --git a/Documentation/userspace-api/media/dvb/video-stillpicture.rst b/Documentation/userspace-api/media/dvb/video-stillpicture.rst
index 5432619a63a1..0335ba6df56a 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_STILLPICTURE:
 
diff --git a/Documentation/userspace-api/media/dvb/video-stop.rst b/Documentation/userspace-api/media/dvb/video-stop.rst
index 9a53fe7f2fd0..bee7da94ce42 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_STOP:
 
diff --git a/Documentation/userspace-api/media/dvb/video-try-command.rst b/Documentation/userspace-api/media/dvb/video-try-command.rst
index 61667952030f..10d6597beeed 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDEO_TRY_COMMAND:
 
diff --git a/Documentation/userspace-api/media/dvb/video.rst b/Documentation/userspace-api/media/dvb/video.rst
index 537eae1b0723..c29948d5760d 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _dvb_video:
 
diff --git a/Documentation/userspace-api/media/dvb/video_function_calls.rst b/Documentation/userspace-api/media/dvb/video_function_calls.rst
index 4902a40d65ba..9e6e38053014 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _video_function_calls:
 
diff --git a/Documentation/userspace-api/media/dvb/video_types.rst b/Documentation/userspace-api/media/dvb/video_types.rst
index bdba1d48f647..8ab7a89e2f28 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _video_types:
 
diff --git a/Documentation/userspace-api/media/fdl-appendix.rst b/Documentation/userspace-api/media/fdl-appendix.rst
index 70c8cda10814..0c73375e69a4 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _fdl:
 
diff --git a/Documentation/userspace-api/media/gen-errors.rst b/Documentation/userspace-api/media/gen-errors.rst
index abae4dbed549..cb804485bcaf 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _gen_errors:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-controller-intro.rst b/Documentation/userspace-api/media/mediactl/media-controller-intro.rst
index 1d06ea4c4d09..3031eaa8b6a9 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _media-controller-intro:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-controller-model.rst b/Documentation/userspace-api/media/mediactl/media-controller-model.rst
index 865e73d934d6..0d4423a7ab59 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _media-controller-model:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-controller.rst b/Documentation/userspace-api/media/mediactl/media-controller.rst
index 16bc3ab180d3..a960a40cde02 100644
--- a/Documentation/userspace-api/media/mediactl/media-controller.rst
+++ b/Documentation/userspace-api/media/mediactl/media-controller.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. include:: <isonum.txt>
 
diff --git a/Documentation/userspace-api/media/mediactl/media-func-close.rst b/Documentation/userspace-api/media/mediactl/media-func-close.rst
index ceec61c9e7c5..5167121b6be4 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _media-func-close:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-func-ioctl.rst b/Documentation/userspace-api/media/mediactl/media-func-ioctl.rst
index 629e7be7c5be..cc7d837a3ff1 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _media-func-ioctl:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-func-open.rst b/Documentation/userspace-api/media/mediactl/media-func-open.rst
index 4ade1cc5048f..571b20bb6e2b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _media-func-open:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-funcs.rst b/Documentation/userspace-api/media/mediactl/media-funcs.rst
index 085e80e7fbd5..e75d203f1247 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _media-user-func:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-header.rst b/Documentation/userspace-api/media/mediactl/media-header.rst
index 7ff9d24ce65f..bedfe83d6a2e 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _media_header:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-ioc-device-info.rst b/Documentation/userspace-api/media/mediactl/media-ioc-device-info.rst
index 9c729bdc8e85..e976bfd42b8b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _media_ioc_device_info:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-ioc-enum-entities.rst b/Documentation/userspace-api/media/mediactl/media-ioc-enum-entities.rst
index 1d01de8e0f97..48c013375a09 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _media_ioc_enum_entities:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-ioc-enum-links.rst b/Documentation/userspace-api/media/mediactl/media-ioc-enum-links.rst
index 9929b639db97..bfb2a724095b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _media_ioc_enum_links:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-ioc-g-topology.rst b/Documentation/userspace-api/media/mediactl/media-ioc-g-topology.rst
index 54e3112a3b5a..6eb56d87ee73 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _media_ioc_g_topology:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-ioc-request-alloc.rst b/Documentation/userspace-api/media/mediactl/media-ioc-request-alloc.rst
index 82f86466c7f2..d2b8d1626136 100644
--- a/Documentation/userspace-api/media/mediactl/media-ioc-request-alloc.rst
+++ b/Documentation/userspace-api/media/mediactl/media-ioc-request-alloc.rst
@@ -1,28 +1,4 @@
-.. This file is dual-licensed: you can use it either under the terms
-.. of the GPL 2.0 or the GFDL 1.1+ license, at your option. Note that this
-.. dual licensing only applies to this file, and not this project as a
-.. whole.
-..
-.. a) This file is free software; you can redistribute it and/or
-..    modify it under the terms of the GNU General Public License as
-..    published by the Free Software Foundation version 2 of
-..    the License.
-..
-..    This file is distributed in the hope that it will be useful,
-..    but WITHOUT ANY WARRANTY; without even the implied warranty of
-..    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-..    GNU General Public License for more details.
-..
-.. Or, alternatively,
-..
-.. b) Permission is granted to copy, distribute and/or modify this
-..    document under the terms of the GNU Free Documentation License,
-..    Version 1.1 or any later version published by the Free Software
-..    Foundation, with no Invariant Sections, no Front-Cover Texts
-..    and no Back-Cover Texts. A copy of the license is included at
-..    Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later-no-invariants
 
 .. _media_ioc_request_alloc:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-ioc-setup-link.rst b/Documentation/userspace-api/media/mediactl/media-ioc-setup-link.rst
index 7da3d0028285..7b5dcfe51d6e 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _media_ioc_setup_link:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-request-ioc-queue.rst b/Documentation/userspace-api/media/mediactl/media-request-ioc-queue.rst
index ad55b6b32616..4c8efe3e4c92 100644
--- a/Documentation/userspace-api/media/mediactl/media-request-ioc-queue.rst
+++ b/Documentation/userspace-api/media/mediactl/media-request-ioc-queue.rst
@@ -1,28 +1,4 @@
-.. This file is dual-licensed: you can use it either under the terms
-.. of the GPL 2.0 or the GFDL 1.1+ license, at your option. Note that this
-.. dual licensing only applies to this file, and not this project as a
-.. whole.
-..
-.. a) This file is free software; you can redistribute it and/or
-..    modify it under the terms of the GNU General Public License as
-..    published by the Free Software Foundation version 2 of
-..    the License.
-..
-..    This file is distributed in the hope that it will be useful,
-..    but WITHOUT ANY WARRANTY; without even the implied warranty of
-..    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-..    GNU General Public License for more details.
-..
-.. Or, alternatively,
-..
-.. b) Permission is granted to copy, distribute and/or modify this
-..    document under the terms of the GNU Free Documentation License,
-..    Version 1.1 or any later version published by the Free Software
-..    Foundation, with no Invariant Sections, no Front-Cover Texts
-..    and no Back-Cover Texts. A copy of the license is included at
-..    Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later-no-invariants
 
 .. _media_request_ioc_queue:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-request-ioc-reinit.rst b/Documentation/userspace-api/media/mediactl/media-request-ioc-reinit.rst
index 4c43fa05c8f6..49c8fa082e73 100644
--- a/Documentation/userspace-api/media/mediactl/media-request-ioc-reinit.rst
+++ b/Documentation/userspace-api/media/mediactl/media-request-ioc-reinit.rst
@@ -1,28 +1,4 @@
-.. This file is dual-licensed: you can use it either under the terms
-.. of the GPL 2.0 or the GFDL 1.1+ license, at your option. Note that this
-.. dual licensing only applies to this file, and not this project as a
-.. whole.
-..
-.. a) This file is free software; you can redistribute it and/or
-..    modify it under the terms of the GNU General Public License as
-..    published by the Free Software Foundation version 2 of
-..    the License.
-..
-..    This file is distributed in the hope that it will be useful,
-..    but WITHOUT ANY WARRANTY; without even the implied warranty of
-..    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-..    GNU General Public License for more details.
-..
-.. Or, alternatively,
-..
-.. b) Permission is granted to copy, distribute and/or modify this
-..    document under the terms of the GNU Free Documentation License,
-..    Version 1.1 or any later version published by the Free Software
-..    Foundation, with no Invariant Sections, no Front-Cover Texts
-..    and no Back-Cover Texts. A copy of the license is included at
-..    Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later-no-invariants
 
 .. _media_request_ioc_reinit:
 
diff --git a/Documentation/userspace-api/media/mediactl/media-types.rst b/Documentation/userspace-api/media/mediactl/media-types.rst
index 77fd4c0c9ebc..859a091b521b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _media-controller-types:
 
diff --git a/Documentation/userspace-api/media/mediactl/request-api.rst b/Documentation/userspace-api/media/mediactl/request-api.rst
index 37d9442a541e..ce61e4134577 100644
--- a/Documentation/userspace-api/media/mediactl/request-api.rst
+++ b/Documentation/userspace-api/media/mediactl/request-api.rst
@@ -1,28 +1,4 @@
-.. This file is dual-licensed: you can use it either under the terms
-.. of the GPL 2.0 or the GFDL 1.1+ license, at your option. Note that this
-.. dual licensing only applies to this file, and not this project as a
-.. whole.
-..
-.. a) This file is free software; you can redistribute it and/or
-..    modify it under the terms of the GNU General Public License as
-..    published by the Free Software Foundation version 2 of
-..    the License.
-..
-..    This file is distributed in the hope that it will be useful,
-..    but WITHOUT ANY WARRANTY; without even the implied warranty of
-..    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-..    GNU General Public License for more details.
-..
-.. Or, alternatively,
-..
-.. b) Permission is granted to copy, distribute and/or modify this
-..    document under the terms of the GNU Free Documentation License,
-..    Version 1.1 or any later version published by the Free Software
-..    Foundation, with no Invariant Sections, no Front-Cover Texts
-..    and no Back-Cover Texts. A copy of the license is included at
-..    Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later-no-invariants
 
 .. _media-request-api:
 
diff --git a/Documentation/userspace-api/media/mediactl/request-func-close.rst b/Documentation/userspace-api/media/mediactl/request-func-close.rst
index 9618b5139764..bd3da80dece9 100644
--- a/Documentation/userspace-api/media/mediactl/request-func-close.rst
+++ b/Documentation/userspace-api/media/mediactl/request-func-close.rst
@@ -1,28 +1,4 @@
-.. This file is dual-licensed: you can use it either under the terms
-.. of the GPL 2.0 or the GFDL 1.1+ license, at your option. Note that this
-.. dual licensing only applies to this file, and not this project as a
-.. whole.
-..
-.. a) This file is free software; you can redistribute it and/or
-..    modify it under the terms of the GNU General Public License as
-..    published by the Free Software Foundation version 2 of
-..    the License.
-..
-..    This file is distributed in the hope that it will be useful,
-..    but WITHOUT ANY WARRANTY; without even the implied warranty of
-..    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-..    GNU General Public License for more details.
-..
-.. Or, alternatively,
-..
-.. b) Permission is granted to copy, distribute and/or modify this
-..    document under the terms of the GNU Free Documentation License,
-..    Version 1.1 or any later version published by the Free Software
-..    Foundation, with no Invariant Sections, no Front-Cover Texts
-..    and no Back-Cover Texts. A copy of the license is included at
-..    Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later-no-invariants
 
 .. _request-func-close:
 
diff --git a/Documentation/userspace-api/media/mediactl/request-func-ioctl.rst b/Documentation/userspace-api/media/mediactl/request-func-ioctl.rst
index 4bf985205bcc..c3c839fd2f31 100644
--- a/Documentation/userspace-api/media/mediactl/request-func-ioctl.rst
+++ b/Documentation/userspace-api/media/mediactl/request-func-ioctl.rst
@@ -1,28 +1,4 @@
-.. This file is dual-licensed: you can use it either under the terms
-.. of the GPL 2.0 or the GFDL 1.1+ license, at your option. Note that this
-.. dual licensing only applies to this file, and not this project as a
-.. whole.
-..
-.. a) This file is free software; you can redistribute it and/or
-..    modify it under the terms of the GNU General Public License as
-..    published by the Free Software Foundation version 2 of
-..    the License.
-..
-..    This file is distributed in the hope that it will be useful,
-..    but WITHOUT ANY WARRANTY; without even the implied warranty of
-..    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-..    GNU General Public License for more details.
-..
-.. Or, alternatively,
-..
-.. b) Permission is granted to copy, distribute and/or modify this
-..    document under the terms of the GNU Free Documentation License,
-..    Version 1.1 or any later version published by the Free Software
-..    Foundation, with no Invariant Sections, no Front-Cover Texts
-..    and no Back-Cover Texts. A copy of the license is included at
-..    Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later-no-invariants
 
 .. _request-func-ioctl:
 
diff --git a/Documentation/userspace-api/media/mediactl/request-func-poll.rst b/Documentation/userspace-api/media/mediactl/request-func-poll.rst
index 85a3427e5913..523d3e7a9e8b 100644
--- a/Documentation/userspace-api/media/mediactl/request-func-poll.rst
+++ b/Documentation/userspace-api/media/mediactl/request-func-poll.rst
@@ -1,28 +1,4 @@
-.. This file is dual-licensed: you can use it either under the terms
-.. of the GPL 2.0 or the GFDL 1.1+ license, at your option. Note that this
-.. dual licensing only applies to this file, and not this project as a
-.. whole.
-..
-.. a) This file is free software; you can redistribute it and/or
-..    modify it under the terms of the GNU General Public License as
-..    published by the Free Software Foundation version 2 of
-..    the License.
-..
-..    This file is distributed in the hope that it will be useful,
-..    but WITHOUT ANY WARRANTY; without even the implied warranty of
-..    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-..    GNU General Public License for more details.
-..
-.. Or, alternatively,
-..
-.. b) Permission is granted to copy, distribute and/or modify this
-..    document under the terms of the GNU Free Documentation License,
-..    Version 1.1 or any later version published by the Free Software
-..    Foundation, with no Invariant Sections, no Front-Cover Texts
-..    and no Back-Cover Texts. A copy of the license is included at
-..    Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later-no-invariants
 
 .. _request-func-poll:
 
diff --git a/Documentation/userspace-api/media/rc/keytable.c.rst b/Documentation/userspace-api/media/rc/keytable.c.rst
index 901d33d37843..b25ba7dc57a5 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 file: uapi/v4l/keytable.c
 =========================
diff --git a/Documentation/userspace-api/media/rc/lirc-dev-intro.rst b/Documentation/userspace-api/media/rc/lirc-dev-intro.rst
index 0c3d70ded55d..906bac82b809 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _lirc_dev_intro:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-dev.rst b/Documentation/userspace-api/media/rc/lirc-dev.rst
index 7a395fa52934..6b80c64a6594 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _lirc_dev:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-func.rst b/Documentation/userspace-api/media/rc/lirc-func.rst
index e37c99583212..51de11d73166 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _lirc_func:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-get-features.rst b/Documentation/userspace-api/media/rc/lirc-get-features.rst
index f4b9ca09f828..7dcb497bb8f8 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _lirc_get_features:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-get-rec-mode.rst b/Documentation/userspace-api/media/rc/lirc-get-rec-mode.rst
index 674ce16d5d33..6c86c87f1ddf 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _lirc_get_rec_mode:
 .. _lirc_set_rec_mode:
diff --git a/Documentation/userspace-api/media/rc/lirc-get-rec-resolution.rst b/Documentation/userspace-api/media/rc/lirc-get-rec-resolution.rst
index f20b5bf41232..f3ec9bbc975b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _lirc_get_rec_resolution:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-get-send-mode.rst b/Documentation/userspace-api/media/rc/lirc-get-send-mode.rst
index 973a47bf6068..34328617bb95 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _lirc_get_send_mode:
 .. _lirc_set_send_mode:
diff --git a/Documentation/userspace-api/media/rc/lirc-get-timeout.rst b/Documentation/userspace-api/media/rc/lirc-get-timeout.rst
index 5db84096d7f8..dc7383086e53 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _lirc_get_min_timeout:
 .. _lirc_get_max_timeout:
diff --git a/Documentation/userspace-api/media/rc/lirc-header.rst b/Documentation/userspace-api/media/rc/lirc-header.rst
index c7e0716da159..564b8564d4e9 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _lirc_header:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-read.rst b/Documentation/userspace-api/media/rc/lirc-read.rst
index 13f7f5353851..51691f493fd3 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _lirc-read:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-set-measure-carrier-mode.rst b/Documentation/userspace-api/media/rc/lirc-set-measure-carrier-mode.rst
index 4cf9472eb904..2ca7b0e43dab 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _lirc_set_measure_carrier_mode:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-set-rec-carrier-range.rst b/Documentation/userspace-api/media/rc/lirc-set-rec-carrier-range.rst
index 0439e93aa267..c4ac9aa00a9a 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _lirc_set_rec_carrier_range:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-set-rec-carrier.rst b/Documentation/userspace-api/media/rc/lirc-set-rec-carrier.rst
index f4d18897cb9f..9cbda58785e8 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _lirc_set_rec_carrier:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-set-rec-timeout-reports.rst b/Documentation/userspace-api/media/rc/lirc-set-rec-timeout-reports.rst
index ab97f87fa757..ae1b65c10851 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _lirc_set_rec_timeout_reports:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-set-rec-timeout.rst b/Documentation/userspace-api/media/rc/lirc-set-rec-timeout.rst
index 227776cf7c62..dd085e304831 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _lirc_set_rec_timeout:
 .. _lirc_get_rec_timeout:
diff --git a/Documentation/userspace-api/media/rc/lirc-set-send-carrier.rst b/Documentation/userspace-api/media/rc/lirc-set-send-carrier.rst
index 7eaf2b993207..8d275ad1f43e 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _lirc_set_send_carrier:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-set-send-duty-cycle.rst b/Documentation/userspace-api/media/rc/lirc-set-send-duty-cycle.rst
index 0dee89364cde..5e264e9e096c 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _lirc_set_send_duty_cycle:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-set-transmitter-mask.rst b/Documentation/userspace-api/media/rc/lirc-set-transmitter-mask.rst
index dcee4b71dcf6..409791e50c0f 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _lirc_set_transmitter_mask:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-set-wideband-receiver.rst b/Documentation/userspace-api/media/rc/lirc-set-wideband-receiver.rst
index 22f6fe43b7e7..aff097e65897 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _lirc_set_wideband_receiver:
 
diff --git a/Documentation/userspace-api/media/rc/lirc-write.rst b/Documentation/userspace-api/media/rc/lirc-write.rst
index 96ca4a22062e..ef8628498162 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _lirc-write:
 
diff --git a/Documentation/userspace-api/media/rc/rc-intro.rst b/Documentation/userspace-api/media/rc/rc-intro.rst
index 14e85157bf23..8fe5b0c2b8a8 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _Remote_controllers_Intro:
 
diff --git a/Documentation/userspace-api/media/rc/rc-protos.rst b/Documentation/userspace-api/media/rc/rc-protos.rst
index b250ebe301d5..fe282e7ec331 100644
--- a/Documentation/userspace-api/media/rc/rc-protos.rst
+++ b/Documentation/userspace-api/media/rc/rc-protos.rst
@@ -1,6 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _Remote_controllers_Protocols:
 
diff --git a/Documentation/userspace-api/media/rc/rc-sysfs-nodes.rst b/Documentation/userspace-api/media/rc/rc-sysfs-nodes.rst
index 73dd75f77d65..2799749dfbf2 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _remote_controllers_sysfs_nodes:
 
diff --git a/Documentation/userspace-api/media/rc/rc-table-change.rst b/Documentation/userspace-api/media/rc/rc-table-change.rst
index f5d00a20b939..69e79d2004c1 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _Remote_controllers_table_change:
 
diff --git a/Documentation/userspace-api/media/rc/rc-tables.rst b/Documentation/userspace-api/media/rc/rc-tables.rst
index 33b724b17ff3..9a5718634f67 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _Remote_controllers_tables:
 
diff --git a/Documentation/userspace-api/media/rc/remote_controllers.rst b/Documentation/userspace-api/media/rc/remote_controllers.rst
index 3ab2d6db1564..9ba4610af9f8 100644
--- a/Documentation/userspace-api/media/rc/remote_controllers.rst
+++ b/Documentation/userspace-api/media/rc/remote_controllers.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. include:: <isonum.txt>
 
diff --git a/Documentation/userspace-api/media/v4l/app-pri.rst b/Documentation/userspace-api/media/v4l/app-pri.rst
index 5018ede2706f..c7f80433be4f 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _app-pri:
 
diff --git a/Documentation/userspace-api/media/v4l/async.rst b/Documentation/userspace-api/media/v4l/async.rst
index 8bc4a726c95e..d22719c4c343 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _async:
 
diff --git a/Documentation/userspace-api/media/v4l/audio.rst b/Documentation/userspace-api/media/v4l/audio.rst
index d6bb85092e02..f04b4d350551 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _audio:
 
diff --git a/Documentation/userspace-api/media/v4l/biblio.rst b/Documentation/userspace-api/media/v4l/biblio.rst
index 3c9634173e82..40b8748c24ad 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 **********
 References
diff --git a/Documentation/userspace-api/media/v4l/buffer.rst b/Documentation/userspace-api/media/v4l/buffer.rst
index 951ae1ed485f..c20d6b7e0e31 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _buffer:
 
diff --git a/Documentation/userspace-api/media/v4l/capture-example.rst b/Documentation/userspace-api/media/v4l/capture-example.rst
index 6aa67c5aff8f..ead3368e3646 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _capture-example:
 
diff --git a/Documentation/userspace-api/media/v4l/capture.c.rst b/Documentation/userspace-api/media/v4l/capture.c.rst
index 30f7c816e858..356892e956cd 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 file: media/v4l/capture.c
 =========================
diff --git a/Documentation/userspace-api/media/v4l/colorspaces-defs.rst b/Documentation/userspace-api/media/v4l/colorspaces-defs.rst
index 01404e1f609a..5659039d53a6 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 ****************************
 Defining Colorspaces in V4L2
diff --git a/Documentation/userspace-api/media/v4l/colorspaces-details.rst b/Documentation/userspace-api/media/v4l/colorspaces-details.rst
index 79ed6f4f76eb..bb2f22cbd5d4 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 ********************************
 Detailed Colorspace Descriptions
diff --git a/Documentation/userspace-api/media/v4l/colorspaces.rst b/Documentation/userspace-api/media/v4l/colorspaces.rst
index 0846df9066c5..c25f9875dea3 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _colorspaces:
 
diff --git a/Documentation/userspace-api/media/v4l/common-defs.rst b/Documentation/userspace-api/media/v4l/common-defs.rst
index 370a1e364a51..e0eeedbb945f 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _common-defs:
 
diff --git a/Documentation/userspace-api/media/v4l/common.rst b/Documentation/userspace-api/media/v4l/common.rst
index 7d81c58a13cd..c5ed9dbf07af 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _common:
 
diff --git a/Documentation/userspace-api/media/v4l/compat.rst b/Documentation/userspace-api/media/v4l/compat.rst
index 055286b86e9b..5c1b495b1148 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _compat:
 
diff --git a/Documentation/userspace-api/media/v4l/control.rst b/Documentation/userspace-api/media/v4l/control.rst
index 3e991c1f7a12..83ce76a90596 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _control:
 
diff --git a/Documentation/userspace-api/media/v4l/crop.rst b/Documentation/userspace-api/media/v4l/crop.rst
index cb7e2341aedf..bb4d58ef9981 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _crop:
 
diff --git a/Documentation/userspace-api/media/v4l/depth-formats.rst b/Documentation/userspace-api/media/v4l/depth-formats.rst
index 6742486a83b5..e6c1a0d06b80 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _depth-formats:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-capture.rst b/Documentation/userspace-api/media/v4l/dev-capture.rst
index 44d3094093ab..8dcf35d96edc 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _capture:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-event.rst b/Documentation/userspace-api/media/v4l/dev-event.rst
index d09034fd680a..3267200acace 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _event:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-mem2mem.rst b/Documentation/userspace-api/media/v4l/dev-mem2mem.rst
index 9279d87c08a1..19c406f3aa43 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _mem2mem:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-meta.rst b/Documentation/userspace-api/media/v4l/dev-meta.rst
index 6d2c5a79b370..d9aa1d36202c 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _metadata:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-osd.rst b/Documentation/userspace-api/media/v4l/dev-osd.rst
index 67dc46373a91..bcb59ae3f26b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _osd:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-output.rst b/Documentation/userspace-api/media/v4l/dev-output.rst
index e4f2a1d8b0fc..5a4570f47129 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _output:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-overlay.rst b/Documentation/userspace-api/media/v4l/dev-overlay.rst
index 7246d560173d..e6850668d586 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _overlay:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-radio.rst b/Documentation/userspace-api/media/v4l/dev-radio.rst
index c0edd7b7d201..cc1062ed839c 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _radio:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-raw-vbi.rst b/Documentation/userspace-api/media/v4l/dev-raw-vbi.rst
index 0307d44e17cb..f6d8d472f89b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _raw-vbi:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-rds.rst b/Documentation/userspace-api/media/v4l/dev-rds.rst
index 13dba4a4180c..e484aada75ac 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _rds:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-sdr.rst b/Documentation/userspace-api/media/v4l/dev-sdr.rst
index c9563bca444e..65b18d98c77a 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _sdr:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-sliced-vbi.rst b/Documentation/userspace-api/media/v4l/dev-sliced-vbi.rst
index dd0b6646beb5..5bc96c8f8d06 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _sliced:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-subdev.rst b/Documentation/userspace-api/media/v4l/dev-subdev.rst
index 134d2fb909fa..edf97a42f464 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _subdev:
 
diff --git a/Documentation/userspace-api/media/v4l/dev-touch.rst b/Documentation/userspace-api/media/v4l/dev-touch.rst
index c1ce446274f2..83592056ce94 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _touch:
 
diff --git a/Documentation/userspace-api/media/v4l/devices.rst b/Documentation/userspace-api/media/v4l/devices.rst
index 47ffe90753dd..3a80fb82271e 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _devices:
 
diff --git a/Documentation/userspace-api/media/v4l/diff-v4l.rst b/Documentation/userspace-api/media/v4l/diff-v4l.rst
index 37644d26c4ae..9cf63a56afe0 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _diff-v4l:
 
diff --git a/Documentation/userspace-api/media/v4l/dmabuf.rst b/Documentation/userspace-api/media/v4l/dmabuf.rst
index 342421ff9497..58e65fdad786 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _dmabuf:
 
diff --git a/Documentation/userspace-api/media/v4l/dv-timings.rst b/Documentation/userspace-api/media/v4l/dv-timings.rst
index e216aa9edef0..2db6f4581a78 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _dv-timings:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
index d9a117f75c9c..a49b735bcecd 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _camera-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index d0d506a444b1..7fb93e848bb6 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _mpeg-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-detect.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-detect.rst
index 77a4992f26bd..fdf19e82d153 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _detect-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-dv.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-dv.rst
index c572b65dc772..76e7ba5277a7 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _dv-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-flash.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-flash.rst
index 5053a380f7de..5b7bdcde309b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _flash-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-fm-rx.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-fm-rx.rst
index 69197bbe23dd..9c631d8bca0e 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _fm-rx-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-fm-tx.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-fm-tx.rst
index c13ec0a6af3a..cf4d9137669e 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _fm-tx-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-image-process.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-image-process.rst
index bb9d484c25e4..d9695722bd2d 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _image-process-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst
index 7b75158aca4d..b0f2da6c0c3f 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _image-source-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-jpeg.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-jpeg.rst
index 5ea69978f3ea..8c904d8d9a3b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _jpeg-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-rf-tuner.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-rf-tuner.rst
index 5277138fce67..6376ebb219f7 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _rf-tuner-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/extended-controls.rst b/Documentation/userspace-api/media/v4l/extended-controls.rst
index 9aa352ac5ea4..ea28b7a3cda1 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _extended-controls:
 
diff --git a/Documentation/userspace-api/media/v4l/field-order.rst b/Documentation/userspace-api/media/v4l/field-order.rst
index 04e9a6932dc5..c9afbf3beda8 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _field-order:
 
diff --git a/Documentation/userspace-api/media/v4l/format.rst b/Documentation/userspace-api/media/v4l/format.rst
index e47fc0505727..7975e86f0444 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _format:
 
diff --git a/Documentation/userspace-api/media/v4l/func-close.rst b/Documentation/userspace-api/media/v4l/func-close.rst
index 37a64dae56b0..3f5819ae5271 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _func-close:
 
diff --git a/Documentation/userspace-api/media/v4l/func-ioctl.rst b/Documentation/userspace-api/media/v4l/func-ioctl.rst
index 4e69f303636b..5e72fc1aa6bd 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _func-ioctl:
 
diff --git a/Documentation/userspace-api/media/v4l/func-mmap.rst b/Documentation/userspace-api/media/v4l/func-mmap.rst
index f9c77bdce434..0fabead6e9f1 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _func-mmap:
 
diff --git a/Documentation/userspace-api/media/v4l/func-munmap.rst b/Documentation/userspace-api/media/v4l/func-munmap.rst
index 18a9941b47ab..0f130a221681 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _func-munmap:
 
diff --git a/Documentation/userspace-api/media/v4l/func-open.rst b/Documentation/userspace-api/media/v4l/func-open.rst
index 8bcdec8ab387..8afa3c4f045e 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _func-open:
 
diff --git a/Documentation/userspace-api/media/v4l/func-poll.rst b/Documentation/userspace-api/media/v4l/func-poll.rst
index 2c6704c1fab7..2c71684877be 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _func-poll:
 
diff --git a/Documentation/userspace-api/media/v4l/func-read.rst b/Documentation/userspace-api/media/v4l/func-read.rst
index 1728aa5d8313..52de54abda87 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _func-read:
 
diff --git a/Documentation/userspace-api/media/v4l/func-select.rst b/Documentation/userspace-api/media/v4l/func-select.rst
index 6aca8a290c1f..81374834ca1a 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _func-select:
 
diff --git a/Documentation/userspace-api/media/v4l/func-write.rst b/Documentation/userspace-api/media/v4l/func-write.rst
index fb1955f70f0f..4173a2185e5d 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _func-write:
 
diff --git a/Documentation/userspace-api/media/v4l/hist-v4l2.rst b/Documentation/userspace-api/media/v4l/hist-v4l2.rst
index 7913d017cd33..7bd5b4d256fd 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _hist-v4l2:
 
diff --git a/Documentation/userspace-api/media/v4l/hsv-formats.rst b/Documentation/userspace-api/media/v4l/hsv-formats.rst
index 4906f7e0d80d..e6dc0f162168 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _hsv-formats:
 
diff --git a/Documentation/userspace-api/media/v4l/io.rst b/Documentation/userspace-api/media/v4l/io.rst
index de0e2f529268..7d0c44fa108a 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _io:
 
diff --git a/Documentation/userspace-api/media/v4l/libv4l-introduction.rst b/Documentation/userspace-api/media/v4l/libv4l-introduction.rst
index 95f3127b4749..96afbe639529 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _libv4l-introduction:
 
diff --git a/Documentation/userspace-api/media/v4l/libv4l.rst b/Documentation/userspace-api/media/v4l/libv4l.rst
index 5ea2016cac65..ec42765028e6 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _libv4l:
 
diff --git a/Documentation/userspace-api/media/v4l/meta-formats.rst b/Documentation/userspace-api/media/v4l/meta-formats.rst
index 7dcc4bacbb0c..44bc89e1b6ab 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _meta-formats:
 
diff --git a/Documentation/userspace-api/media/v4l/mmap.rst b/Documentation/userspace-api/media/v4l/mmap.rst
index 9c44d05ebc3f..49b93624309c 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _mmap:
 
diff --git a/Documentation/userspace-api/media/v4l/open.rst b/Documentation/userspace-api/media/v4l/open.rst
index 38046ef20141..7d2ae437c34b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _open:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-bayer.rst b/Documentation/userspace-api/media/v4l/pixfmt-bayer.rst
index be9a8385ebc1..03cd4a9e0820 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _pixfmt-bayer:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
index 3828bb79225d..656f306dfb58 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 ******************
 Compressed Formats
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-grey.rst b/Documentation/userspace-api/media/v4l/pixfmt-grey.rst
index 7b03db3393be..2e21374cf0b3 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-GREY:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-indexed.rst b/Documentation/userspace-api/media/v4l/pixfmt-indexed.rst
index d0d46ed27260..763f88133432 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _pixfmt-indexed:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-intro.rst b/Documentation/userspace-api/media/v4l/pixfmt-intro.rst
index af870895f653..a778f0916c51 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 **********************
 Standard Image Formats
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-inzi.rst b/Documentation/userspace-api/media/v4l/pixfmt-inzi.rst
index f85cccb71741..80661cfcbd55 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-INZI:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-m420.rst b/Documentation/userspace-api/media/v4l/pixfmt-m420.rst
index 5180bbe16c6e..e694df6f8764 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-M420:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst b/Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.rst
index 4eaf2f9086a9..404b08c38a4d 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _v4l2-meta-fmt-d4xx:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-intel-ipu3.rst b/Documentation/userspace-api/media/v4l/pixfmt-meta-intel-ipu3.rst
index 97a9a2925671..9735c07a5ada 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-meta-intel-ipu3.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-meta-intel-ipu3.rst
@@ -1,27 +1,4 @@
-.. This file is dual-licensed: you can use it either under the terms
-.. of the GPL 2.0 or the GFDL 1.1+ license, at your option. Note that this
-.. dual licensing only applies to this file, and not this project as a
-.. whole.
-..
-.. a) This file is free software; you can redistribute it and/or
-..    modify it under the terms of the GNU General Public License version
-..    2.0 as published by the Free Software Foundation.
-..
-..    This file is distributed in the hope that it will be useful,
-..    but WITHOUT ANY WARRANTY; without even the implied warranty of
-..    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-..    GNU General Public License version 2.0 for more details.
-..
-.. Or, alternatively,
-..
-.. b) Permission is granted to copy, distribute and/or modify this
-..    document under the terms of the GNU Free Documentation License,
-..    Version 1.1 or any later version published by the Free Software
-..    Foundation, with no Invariant Sections, no Front-Cover Texts
-..    and no Back-Cover Texts. A copy of the license is included at
-..    Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later-no-invariants
 
 .. _v4l2-meta-fmt-params:
 .. _v4l2-meta-fmt-stat-3a:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-uvc.rst b/Documentation/userspace-api/media/v4l/pixfmt-meta-uvc.rst
index debc50285a25..3025d8088c7a 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _v4l2-meta-fmt-uvc:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-vivid.rst b/Documentation/userspace-api/media/v4l/pixfmt-meta-vivid.rst
index 34a2382ef91c..a47b10f86473 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-meta-vivid.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-meta-vivid.rst
@@ -1,28 +1,4 @@
-.. This file is dual-licensed: you can use it either under the terms
-.. of the GPL 2.0 or the GFDL 1.1+ license, at your option. Note that this
-.. dual licensing only applies to this file, and not this project as a
-.. whole.
-..
-.. a) This file is free software; you can redistribute it and/or
-..    modify it under the terms of the GNU General Public License as
-..    published by the Free Software Foundation version 2 of
-..    the License.
-..
-..    This file is distributed in the hope that it will be useful,
-..    but WITHOUT ANY WARRANTY; without even the implied warranty of
-..    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-..    GNU General Public License for more details.
-..
-.. Or, alternatively,
-..
-.. b) Permission is granted to copy, distribute and/or modify this
-..    document under the terms of the GNU Free Documentation License,
-..    Version 1.1 or any later version published by the Free Software
-..    Foundation, with no Invariant Sections, no Front-Cover Texts
-..    and no Back-Cover Texts. A copy of the license is included at
-..    Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GPL-2.0 OR GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-or-later-no-invariants
 
 .. _v4l2-meta-fmt-vivid:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-vsp1-hgo.rst b/Documentation/userspace-api/media/v4l/pixfmt-meta-vsp1-hgo.rst
index b780e447dd4b..a75e534058f9 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _v4l2-meta-fmt-vsp1-hgo:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-vsp1-hgt.rst b/Documentation/userspace-api/media/v4l/pixfmt-meta-vsp1-hgt.rst
index e165320cc1ff..cf0564f8fecd 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _v4l2-meta-fmt-vsp1-hgt:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-nv12.rst b/Documentation/userspace-api/media/v4l/pixfmt-nv12.rst
index 19d47b38e02a..737f127ee1d1 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-NV12:
 .. _V4L2-PIX-FMT-NV21:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-nv12m.rst b/Documentation/userspace-api/media/v4l/pixfmt-nv12m.rst
index 115ea603c13f..c776c9d6a97b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-NV12M:
 .. _v4l2-pix-fmt-nv12mt-16x16:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-nv12mt.rst b/Documentation/userspace-api/media/v4l/pixfmt-nv12mt.rst
index daac1c16d4f2..012839fcc429 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-NV12MT:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-nv16.rst b/Documentation/userspace-api/media/v4l/pixfmt-nv16.rst
index 977636fc98d6..ddb7b595f264 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-NV16:
 .. _V4L2-PIX-FMT-NV61:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-nv16m.rst b/Documentation/userspace-api/media/v4l/pixfmt-nv16m.rst
index cf33942d942d..02c76b96116d 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-NV16M:
 .. _v4l2-pix-fmt-nv61m:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-nv24.rst b/Documentation/userspace-api/media/v4l/pixfmt-nv24.rst
index c6fb97bd0472..ccce8498da96 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-NV24:
 .. _V4L2-PIX-FMT-NV42:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-packed-hsv.rst b/Documentation/userspace-api/media/v4l/pixfmt-packed-hsv.rst
index b8c9b0225eea..95a618b0c9d3 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _packed-hsv:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
index bbd4bd094deb..8ccd01deb6cd 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _packed-yuv:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
index 59b9e7238f90..6d3d52432b33 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _pixfmt-reserved:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst b/Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
index 89cc2a37b285..c75d057babd5 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _pixfmt-rgb:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-sdr-cs08.rst b/Documentation/userspace-api/media/v4l/pixfmt-sdr-cs08.rst
index 13f3908d162a..80a9ffd25f08 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _v4l2-sdr-fmt-cs8:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-sdr-cs14le.rst b/Documentation/userspace-api/media/v4l/pixfmt-sdr-cs14le.rst
index 41e5b990d499..ae6cbc160471 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-SDR-FMT-CS14LE:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-sdr-cu08.rst b/Documentation/userspace-api/media/v4l/pixfmt-sdr-cu08.rst
index 1085b5ad8eb7..608403d06bf1 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _v4l2-sdr-fmt-cu8:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-sdr-cu16le.rst b/Documentation/userspace-api/media/v4l/pixfmt-sdr-cu16le.rst
index 9772b30bda95..ee6539ef4760 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-SDR-FMT-CU16LE:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu16be.rst b/Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu16be.rst
index 53a0a862f33a..6e5434e60a01 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-SDR-FMT-PCU16BE:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu18be.rst b/Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu18be.rst
index 7f2d2545fb04..6b695141e468 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-SDR-FMT-PCU18BE:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu20be.rst b/Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu20be.rst
index 9f3d67b4e94c..99e578d1733b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-SDR-FMT-PCU20BE:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-sdr-ru12le.rst b/Documentation/userspace-api/media/v4l/pixfmt-sdr-ru12le.rst
index c9cde8d425f7..b31d3b34834c 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-SDR-FMT-RU12LE:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb10-ipu3.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb10-ipu3.rst
index 5afa02a66698..db776321e854 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _v4l2-pix-fmt-ipu3-sbggr10:
 .. _v4l2-pix-fmt-ipu3-sgbrg10:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb10.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb10.rst
index 37cc1bb8241f..7b75dcc11611 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-SRGGB10:
 .. _v4l2-pix-fmt-sbggr10:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb10alaw8.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb10alaw8.rst
index f1b8627f0141..6ecf40bbb754 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-SBGGR10ALAW8:
 .. _v4l2-pix-fmt-sgbrg10alaw8:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb10dpcm8.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb10dpcm8.rst
index 9814c4ffac68..fe99aca718ad 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-SBGGR10DPCM8:
 .. _v4l2-pix-fmt-sgbrg10dpcm8:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb10p.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb10p.rst
index 76a4d278e640..e917a0054fa5 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-SRGGB10P:
 .. _v4l2-pix-fmt-sbggr10p:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb12.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb12.rst
index 98ae80b968ae..6c1a66f67f13 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-SRGGB12:
 .. _v4l2-pix-fmt-sbggr12:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb12p.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb12p.rst
index 7309dd7fa60f..345b3f5486f5 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-SRGGB12P:
 .. _v4l2-pix-fmt-sbggr12p:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb14.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb14.rst
index a4c7a392fe7f..215f1be5b60c 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-SRGGB14:
 .. _v4l2-pix-fmt-sbggr14:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb14p.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb14p.rst
index ec1239ada316..7c003dff2787 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-SRGGB14P:
 .. _v4l2-pix-fmt-sbggr14p:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb16.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb16.rst
index 885f0d1f331d..b6d8275e683e 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-SRGGB16:
 .. _v4l2-pix-fmt-sbggr16:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-srggb8.rst b/Documentation/userspace-api/media/v4l/pixfmt-srggb8.rst
index c275e6ef09f9..0632597065c8 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-SRGGB8:
 .. _v4l2-pix-fmt-sbggr8:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-tch-td08.rst b/Documentation/userspace-api/media/v4l/pixfmt-tch-td08.rst
index 165c9be2bfc5..39c0fb205e40 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-TCH-FMT-DELTA-TD08:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-tch-td16.rst b/Documentation/userspace-api/media/v4l/pixfmt-tch-td16.rst
index 6dca01182175..6efcd7137154 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-TCH-FMT-DELTA-TD16:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-tch-tu08.rst b/Documentation/userspace-api/media/v4l/pixfmt-tch-tu08.rst
index f1380b72977f..22c2d428ea8f 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-TCH-FMT-TU08:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-tch-tu16.rst b/Documentation/userspace-api/media/v4l/pixfmt-tch-tu16.rst
index 2b9e1b15abcf..28aaed46776e 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-TCH-FMT-TU16:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-uv8.rst b/Documentation/userspace-api/media/v4l/pixfmt-uv8.rst
index a36c1a4d64a4..8bc7ea7306df 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-UV8:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-uyvy.rst b/Documentation/userspace-api/media/v4l/pixfmt-uyvy.rst
index 776cb37f76f1..f91402ab80ee 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-UYVY:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-v4l2-mplane.rst b/Documentation/userspace-api/media/v4l/pixfmt-v4l2-mplane.rst
index 444b4082684c..d27250c33821 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 ******************************
 Multi-planar format structures
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-v4l2.rst b/Documentation/userspace-api/media/v4l/pixfmt-v4l2.rst
index 759420a872d6..7fcb1f2debcc 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 ******************************
 Single-planar format structure
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-vyuy.rst b/Documentation/userspace-api/media/v4l/pixfmt-vyuy.rst
index 6cd574e78e4c..272e97d5a853 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-VYUY:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-y10.rst b/Documentation/userspace-api/media/v4l/pixfmt-y10.rst
index dfb352ae6784..6c1b02988a42 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-Y10:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-y10b.rst b/Documentation/userspace-api/media/v4l/pixfmt-y10b.rst
index b5d89d6d5c52..ef4692bc3bc0 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-Y10BPACK:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-y10p.rst b/Documentation/userspace-api/media/v4l/pixfmt-y10p.rst
index ffb6e1631b78..0879de517180 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-Y10P:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-y12.rst b/Documentation/userspace-api/media/v4l/pixfmt-y12.rst
index 4226c49232de..d935690c0883 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-Y12:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-y12i.rst b/Documentation/userspace-api/media/v4l/pixfmt-y12i.rst
index b4752754337b..fc9a602a4391 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-Y12I:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-y14.rst b/Documentation/userspace-api/media/v4l/pixfmt-y14.rst
index d702b6549160..c45ca1876a0b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-Y14:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-y16-be.rst b/Documentation/userspace-api/media/v4l/pixfmt-y16-be.rst
index f4eda7b95b51..87e27bc6e201 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-Y16-BE:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-y16.rst b/Documentation/userspace-api/media/v4l/pixfmt-y16.rst
index a092b0a5ff12..2f85945365d9 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-Y16:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-y41p.rst b/Documentation/userspace-api/media/v4l/pixfmt-y41p.rst
index 211afd7593cc..281c6d258850 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-Y41P:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-y8i.rst b/Documentation/userspace-api/media/v4l/pixfmt-y8i.rst
index 4248c6f735b7..db1b3cedc9df 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-Y8I:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv410.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv410.rst
index 1d20115f2b1d..2a921e223b2c 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-YVU410:
 .. _v4l2-pix-fmt-yuv410:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv411p.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv411p.rst
index 967ba7ce41a2..0a70308bf0e1 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-YUV411P:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv420.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv420.rst
index 7cb685cc8289..1a5425bd4aa9 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-YVU420:
 .. _V4L2-PIX-FMT-YUV420:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv420m.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv420m.rst
index 80c14d4f5acb..152d24a6140c 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-YUV420M:
 .. _v4l2-pix-fmt-yvu420m:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv422m.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv422m.rst
index 29b78480ccad..adda11bb8eea 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-YUV422M:
 .. _v4l2-pix-fmt-yvu422m:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv422p.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv422p.rst
index 73fde222d820..5aa8f8d7d769 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-YUV422P:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv444m.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv444m.rst
index 7073ac7f842d..19a798590723 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-YUV444M:
 .. _v4l2-pix-fmt-yvu444m:
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuyv.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuyv.rst
index fe70e007787d..c8fb708d83a8 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-YUYV:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yvyu.rst b/Documentation/userspace-api/media/v4l/pixfmt-yvyu.rst
index 96c1b537d5a0..0c0e3e4a82c4 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-YVYU:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-z16.rst b/Documentation/userspace-api/media/v4l/pixfmt-z16.rst
index fe2fb21edeea..da1b8d93b23e 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _V4L2-PIX-FMT-Z16:
 
diff --git a/Documentation/userspace-api/media/v4l/pixfmt.rst b/Documentation/userspace-api/media/v4l/pixfmt.rst
index 70ca3a5c2cf1..fecc8a987c35 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _pixfmt:
 
diff --git a/Documentation/userspace-api/media/v4l/planar-apis.rst b/Documentation/userspace-api/media/v4l/planar-apis.rst
index 6247b0c4ab4d..7764382cffc7 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _planar-apis:
 
diff --git a/Documentation/userspace-api/media/v4l/querycap.rst b/Documentation/userspace-api/media/v4l/querycap.rst
index 35fba2a9e09b..1bc808d0014b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _querycap:
 
diff --git a/Documentation/userspace-api/media/v4l/rw.rst b/Documentation/userspace-api/media/v4l/rw.rst
index ce2768c994d0..97b5281bdc46 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _rw:
 
diff --git a/Documentation/userspace-api/media/v4l/sdr-formats.rst b/Documentation/userspace-api/media/v4l/sdr-formats.rst
index b7a1be75251f..465b1361469d 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _sdr-formats:
 
diff --git a/Documentation/userspace-api/media/v4l/selection-api-configuration.rst b/Documentation/userspace-api/media/v4l/selection-api-configuration.rst
index 67ff67fd734e..c57a9cf4f2c7 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 *************
 Configuration
diff --git a/Documentation/userspace-api/media/v4l/selection-api-examples.rst b/Documentation/userspace-api/media/v4l/selection-api-examples.rst
index 2f4027211129..9c0b9f9a07b1 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 ********
 Examples
diff --git a/Documentation/userspace-api/media/v4l/selection-api-intro.rst b/Documentation/userspace-api/media/v4l/selection-api-intro.rst
index 0994ca25be5e..9641e766df2c 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 ************
 Introduction
diff --git a/Documentation/userspace-api/media/v4l/selection-api-targets.rst b/Documentation/userspace-api/media/v4l/selection-api-targets.rst
index 56eab969c9d8..79b2c58504a2 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 *****************
 Selection targets
diff --git a/Documentation/userspace-api/media/v4l/selection-api-vs-crop-api.rst b/Documentation/userspace-api/media/v4l/selection-api-vs-crop-api.rst
index a9360a000022..fa4da885fc09 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _selection-vs-crop:
 
diff --git a/Documentation/userspace-api/media/v4l/selection-api.rst b/Documentation/userspace-api/media/v4l/selection-api.rst
index b86e387721df..9e5b4b6ef172 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _selection-api:
 
diff --git a/Documentation/userspace-api/media/v4l/selections-common.rst b/Documentation/userspace-api/media/v4l/selections-common.rst
index d5ea05869a61..73ef1c9e84f1 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _v4l2-selections-common:
 
diff --git a/Documentation/userspace-api/media/v4l/standard.rst b/Documentation/userspace-api/media/v4l/standard.rst
index 61c341508eb3..90605a944b78 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _standard:
 
diff --git a/Documentation/userspace-api/media/v4l/streaming-par.rst b/Documentation/userspace-api/media/v4l/streaming-par.rst
index 6d1a1b93ac8b..0572ac24d0ad 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _streaming-par:
 
diff --git a/Documentation/userspace-api/media/v4l/subdev-formats.rst b/Documentation/userspace-api/media/v4l/subdev-formats.rst
index 9a4d61b0d76f..9ad7ec98bf0e 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _v4l2-mbus-format:
 
diff --git a/Documentation/userspace-api/media/v4l/tch-formats.rst b/Documentation/userspace-api/media/v4l/tch-formats.rst
index f83aec85fd76..0eb83ab67825 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _tch-formats:
 
diff --git a/Documentation/userspace-api/media/v4l/tuner.rst b/Documentation/userspace-api/media/v4l/tuner.rst
index 02a396eb6613..ec1819538aa8 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _tuner:
 
diff --git a/Documentation/userspace-api/media/v4l/user-func.rst b/Documentation/userspace-api/media/v4l/user-func.rst
index bf77c842718e..255e0ca1c15a 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _user-func:
 
diff --git a/Documentation/userspace-api/media/v4l/userp.rst b/Documentation/userspace-api/media/v4l/userp.rst
index 2d0fa7353066..22742a0719e9 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _userp:
 
diff --git a/Documentation/userspace-api/media/v4l/v4l2-selection-flags.rst b/Documentation/userspace-api/media/v4l/v4l2-selection-flags.rst
index 5c6f351b2443..9ee33482964f 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _v4l2-selection-flags:
 
diff --git a/Documentation/userspace-api/media/v4l/v4l2-selection-targets.rst b/Documentation/userspace-api/media/v4l/v4l2-selection-targets.rst
index 69f500093aa2..6160bf324740 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _v4l2-selection-targets:
 
diff --git a/Documentation/userspace-api/media/v4l/v4l2.rst b/Documentation/userspace-api/media/v4l/v4l2.rst
index ab7c97c39b97..6efc2c6978c0 100644
--- a/Documentation/userspace-api/media/v4l/v4l2.rst
+++ b/Documentation/userspace-api/media/v4l/v4l2.rst
@@ -1,11 +1,4 @@
-.. Permission is granted to copy, distribute and/or modify this
-.. document under the terms of the GNU Free Documentation License,
-.. Version 1.1 or any later version published by the Free Software
-.. Foundation, with no Invariant Sections, no Front-Cover Texts
-.. and no Back-Cover Texts. A copy of the license is included at
-.. Documentation/userspace-api/media/fdl-appendix.rst.
-..
-.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. include:: <isonum.txt>
 .. _v4l2spec:
diff --git a/Documentation/userspace-api/media/v4l/v4l2grab-example.rst b/Documentation/userspace-api/media/v4l/v4l2grab-example.rst
index 270738876f72..1da407ca991d 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _v4l2grab-example:
 
diff --git a/Documentation/userspace-api/media/v4l/v4l2grab.c.rst b/Documentation/userspace-api/media/v4l/v4l2grab.c.rst
index a21ff357a830..67f8244734e3 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 file: media/v4l/v4l2grab.c
 ==========================
diff --git a/Documentation/userspace-api/media/v4l/video.rst b/Documentation/userspace-api/media/v4l/video.rst
index 9b73dba0eb8d..ad3991c6243c 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _video:
 
diff --git a/Documentation/userspace-api/media/v4l/videodev.rst b/Documentation/userspace-api/media/v4l/videodev.rst
index c8244b895802..f25758b090c9 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _videodev:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst b/Documentation/userspace-api/media/v4l/vidioc-create-bufs.rst
index e1afc5b504c2..0d771cdc17ca 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_CREATE_BUFS:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-cropcap.rst b/Documentation/userspace-api/media/v4l/vidioc-cropcap.rst
index 035ed9d577ae..e4b0590434ed 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_CROPCAP:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-dbg-g-chip-info.rst b/Documentation/userspace-api/media/v4l/vidioc-dbg-g-chip-info.rst
index 16078a2d3e3d..e0249dcf0b0f 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_DBG_G_CHIP_INFO:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-dbg-g-register.rst b/Documentation/userspace-api/media/v4l/vidioc-dbg-g-register.rst
index 6311a63278a5..3e9f317211b5 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_DBG_G_REGISTER:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-decoder-cmd.rst b/Documentation/userspace-api/media/v4l/vidioc-decoder-cmd.rst
index 7986a248bff9..33dd63abf225 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_DECODER_CMD:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst b/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
index a9a176d5256d..fb19308989cb 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_DQEVENT:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-dv-timings-cap.rst b/Documentation/userspace-api/media/v4l/vidioc-dv-timings-cap.rst
index 60730c32bfe4..2937e6bfe8c4 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_DV_TIMINGS_CAP:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-encoder-cmd.rst b/Documentation/userspace-api/media/v4l/vidioc-encoder-cmd.rst
index 16269b3b1715..d2b14ef3e2e4 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_ENCODER_CMD:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enum-dv-timings.rst b/Documentation/userspace-api/media/v4l/vidioc-enum-dv-timings.rst
index 89d6b860193a..8bd1027119b5 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_ENUM_DV_TIMINGS:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst b/Documentation/userspace-api/media/v4l/vidioc-enum-fmt.rst
index a53dd3d7f7e2..e7e25144e43b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_ENUM_FMT:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enum-frameintervals.rst b/Documentation/userspace-api/media/v4l/vidioc-enum-frameintervals.rst
index 0e3db737371f..a719a017ac14 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_ENUM_FRAMEINTERVALS:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enum-framesizes.rst b/Documentation/userspace-api/media/v4l/vidioc-enum-framesizes.rst
index 1934d7da9743..8f3564093bff 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_ENUM_FRAMESIZES:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enum-freq-bands.rst b/Documentation/userspace-api/media/v4l/vidioc-enum-freq-bands.rst
index ee3ba67601fa..d537169cd46d 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_ENUM_FREQ_BANDS:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enumaudio.rst b/Documentation/userspace-api/media/v4l/vidioc-enumaudio.rst
index afe4821e5863..54906545bfa4 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_ENUMAUDIO:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enumaudioout.rst b/Documentation/userspace-api/media/v4l/vidioc-enumaudioout.rst
index 31c2ae460e2d..e7cbdebfe114 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_ENUMAUDOUT:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enuminput.rst b/Documentation/userspace-api/media/v4l/vidioc-enuminput.rst
index 510670bff3de..07cec3171666 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_ENUMINPUT:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enumoutput.rst b/Documentation/userspace-api/media/v4l/vidioc-enumoutput.rst
index 591a99cf8000..e879919d1d07 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_ENUMOUTPUT:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-enumstd.rst b/Documentation/userspace-api/media/v4l/vidioc-enumstd.rst
index 8a0508536c13..db0008c4166f 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_ENUMSTD:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-expbuf.rst b/Documentation/userspace-api/media/v4l/vidioc-expbuf.rst
index 384a9be9eba0..379baee7ec9c 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_EXPBUF:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-audio.rst b/Documentation/userspace-api/media/v4l/vidioc-g-audio.rst
index 68531bcb62ab..0d7574652ae7 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_AUDIO:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-audioout.rst b/Documentation/userspace-api/media/v4l/vidioc-g-audioout.rst
index e13b74bf5ce3..fb8a048d2fd2 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_AUDOUT:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-crop.rst b/Documentation/userspace-api/media/v4l/vidioc-g-crop.rst
index 10e086be55d5..b4e2aa299c69 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_CROP:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-ctrl.rst b/Documentation/userspace-api/media/v4l/vidioc-g-ctrl.rst
index 9831b7514028..0555c031e17f 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_CTRL:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-dv-timings.rst b/Documentation/userspace-api/media/v4l/vidioc-g-dv-timings.rst
index 9a035a4ea0f0..9d29faf63b12 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_DV_TIMINGS:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-edid.rst b/Documentation/userspace-api/media/v4l/vidioc-g-edid.rst
index 0620f4cbbcbd..b827b04af23c 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_EDID:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-enc-index.rst b/Documentation/userspace-api/media/v4l/vidioc-g-enc-index.rst
index 8aad30a7c6c3..cd5bbf3c02d3 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_ENC_INDEX:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst b/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
index add17c9204cb..637263ee26f2 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_EXT_CTRLS:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-fbuf.rst b/Documentation/userspace-api/media/v4l/vidioc-g-fbuf.rst
index 0124444419ae..fdc9291963aa 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_FBUF:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-fmt.rst b/Documentation/userspace-api/media/v4l/vidioc-g-fmt.rst
index 88bb69ec07e2..3612666622a7 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_FMT:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-frequency.rst b/Documentation/userspace-api/media/v4l/vidioc-g-frequency.rst
index 26300e0258a3..0ec01494461f 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_FREQUENCY:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-input.rst b/Documentation/userspace-api/media/v4l/vidioc-g-input.rst
index 294e346678c1..ff1bc5222ac4 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_INPUT:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-jpegcomp.rst b/Documentation/userspace-api/media/v4l/vidioc-g-jpegcomp.rst
index 3b9981dcb8e0..15a445888ba0 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_JPEGCOMP:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-modulator.rst b/Documentation/userspace-api/media/v4l/vidioc-g-modulator.rst
index c2072f6e8756..81ac090d898c 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_MODULATOR:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-output.rst b/Documentation/userspace-api/media/v4l/vidioc-g-output.rst
index cad477420fd7..b6450321926e 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_OUTPUT:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-parm.rst b/Documentation/userspace-api/media/v4l/vidioc-g-parm.rst
index 42e9f6ee7a59..e518dbe47825 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_PARM:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-priority.rst b/Documentation/userspace-api/media/v4l/vidioc-g-priority.rst
index c8add130c7a4..5c7346899d98 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_PRIORITY:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-selection.rst b/Documentation/userspace-api/media/v4l/vidioc-g-selection.rst
index faab0454b1e4..488478887dcf 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_SELECTION:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-sliced-vbi-cap.rst b/Documentation/userspace-api/media/v4l/vidioc-g-sliced-vbi-cap.rst
index 7a62c4f4e37f..eb9fb0273a7a 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_SLICED_VBI_CAP:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-std.rst b/Documentation/userspace-api/media/v4l/vidioc-g-std.rst
index 6d8cb7f29ac6..bff391789e52 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_STD:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-tuner.rst b/Documentation/userspace-api/media/v4l/vidioc-g-tuner.rst
index 40bff6f0a88d..4296e92b98da 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_G_TUNER:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-log-status.rst b/Documentation/userspace-api/media/v4l/vidioc-log-status.rst
index 64c06fa72b9c..4c58a0d13407 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_LOG_STATUS:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-overlay.rst b/Documentation/userspace-api/media/v4l/vidioc-overlay.rst
index 74310ff486ba..cd0ed0b53fbf 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_OVERLAY:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-prepare-buf.rst b/Documentation/userspace-api/media/v4l/vidioc-prepare-buf.rst
index b6c09d5b128f..20ac4ce54038 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_PREPARE_BUF:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-qbuf.rst b/Documentation/userspace-api/media/v4l/vidioc-qbuf.rst
index ec0a54fbeb43..10391f8eddcd 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_QBUF:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-query-dv-timings.rst b/Documentation/userspace-api/media/v4l/vidioc-query-dv-timings.rst
index ab86408446f3..a6ccdac77e46 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_QUERY_DV_TIMINGS:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-querybuf.rst b/Documentation/userspace-api/media/v4l/vidioc-querybuf.rst
index 646f91140ccf..b054f6f0a370 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_QUERYBUF:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-querycap.rst b/Documentation/userspace-api/media/v4l/vidioc-querycap.rst
index 666ac4d42051..f4a8c66e11b4 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_QUERYCAP:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst b/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
index fbb0038d86bf..5ef4606d3252 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_QUERYCTRL:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-querystd.rst b/Documentation/userspace-api/media/v4l/vidioc-querystd.rst
index 899f0ef6eefe..df7ae99adabe 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_QUERYSTD:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
index b6d52083707b..5c2b49780ea3 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_REQBUFS:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-s-hw-freq-seek.rst b/Documentation/userspace-api/media/v4l/vidioc-s-hw-freq-seek.rst
index 4c16e7e89cfa..abbb98ef0595 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_S_HW_FREQ_SEEK:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-streamon.rst b/Documentation/userspace-api/media/v4l/vidioc-streamon.rst
index 13e0136d5c25..cdbbe6942360 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_STREAMON:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-interval.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-interval.rst
index 3527745935c7..31ea05b810b1 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_SUBDEV_ENUM_FRAME_INTERVAL:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-size.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-size.rst
index eb7401991d02..dfaa5ae3c894 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_SUBDEV_ENUM_FRAME_SIZE:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst
index 35b8607203a4..b40e95db3185 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_SUBDEV_ENUM_MBUS_CODE:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-g-crop.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-g-crop.rst
index 615e3efdf935..e53cb984ac7c 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_SUBDEV_G_CROP:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-g-fmt.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-g-fmt.rst
index 909ee9f90867..d471682f41ff 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_SUBDEV_G_FMT:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-g-frame-interval.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-g-frame-interval.rst
index 51e1bff797f0..a74ffeeb095b 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_SUBDEV_G_FRAME_INTERVAL:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-g-selection.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-g-selection.rst
index 06c9553ac48f..351a48791cd5 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_SUBDEV_G_SELECTION:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-querycap.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-querycap.rst
index 0371a76321af..5f4ec60fcb66 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_SUBDEV_QUERYCAP:
 
diff --git a/Documentation/userspace-api/media/v4l/vidioc-subscribe-event.rst b/Documentation/userspace-api/media/v4l/vidioc-subscribe-event.rst
index ae3ed73c0a9e..010bdfd813f4 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _VIDIOC_SUBSCRIBE_EVENT:
 .. _VIDIOC_UNSUBSCRIBE_EVENT:
diff --git a/Documentation/userspace-api/media/v4l/yuv-formats.rst b/Documentation/userspace-api/media/v4l/yuv-formats.rst
index 8ee92d0cd769..b9207366b8d3 100644
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
+.. SPDX-License-Identifier: GFDL-1.1-or-later-no-invariants
 
 .. _yuv-formats:
 
-- 
2.26.2

