Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E24C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25F8222C4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lptq6yk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgCBRkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:40:24 -0500
Received: from mail-pj1-f51.google.com ([209.85.216.51]:38704 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgCBRkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:40:23 -0500
Received: by mail-pj1-f51.google.com with SMTP id a16so77362pju.3;
        Mon, 02 Mar 2020 09:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nkMKOOaw3P2B6rK41NPDUDXIHV+H/zXd6XgL+vXeQhE=;
        b=lptq6yk4XKnjGGkNuFFeFNb4JsywO++DNQxxOEi2qyHQjmIQ5RppxbHEvhMpgrIU4+
         7IzIp4qeWwMg3rE2KNopWeAMEQclp33v841BYpdbDRXTdg1zeh7y+qQBEorLQKhGZ0/s
         pno8mvdV5v6lrLPQdnc8Xq6goSYD/C0GfYopjzDed/pg5Z1xDkqaHhbZm8vuhYtHp92r
         /qWoL2KaeYdUzMiDbLcIlDcaTXFIoZBW6L7UgfIDlZ7JkB5gJnJhjGNxiOsUCXq0SrUc
         G9mxlfOe7IaThsfdDQnqVrcNAEqgUJORtZueydqUuMrUqSSujwGk4p4RHXKjBUXHcVuP
         2czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nkMKOOaw3P2B6rK41NPDUDXIHV+H/zXd6XgL+vXeQhE=;
        b=WAojflab+Yl+Xb/Xg+DzTWRdLL/B6OJTSDKlxw9OQScCEkQFu308oA3/fUiIeB8SZe
         lJOUfQlMCCbjYQshkiwpgDwZdNXQQYRIWUekJJE+EuQNDkCX8KMFJRABB0ZvtAy9c3X2
         o0Opyy5ve3amcxMZVatW0XJ7TxKCzDWyUhzKlLLAd3B9vu6Grc94WI5TJPM6/xkjwb7Z
         YOyZjVyWIAzIG4bMwBA1tK12nbb2HHOHphNWbtaEICQL2u0cOFgBqdTdAgbgdg37SqFY
         HnUQ6orbyG3SzP2MMYNgtGpalXRwnSk+Q4trd3AMRUAk8jNRw4a1qbZSoXW0iJfXMT7I
         VY9A==
X-Gm-Message-State: ANhLgQ0/F7G67o6DL7glIAqlX5t3/njLA5mAeZFcJe7bZYIASi0TfXZ6
        m0QHdrUfjwuacCAC0E4gGf4=
X-Google-Smtp-Source: ADFU+vvUIBMvIEkf5ymB6RpnPitm5J1tEWtFnzSzWWNAqfuoK3Tu4LxVcpfUUKzgIJFjQk5jXcnK0A==
X-Received: by 2002:a17:902:b904:: with SMTP id bf4mr278549plb.151.1583170821152;
        Mon, 02 Mar 2020 09:40:21 -0800 (PST)
Received: from localhost.localdomain ([2405:204:800a:15c3:b0b0:78ba:d728:349e])
        by smtp.gmail.com with ESMTPSA id c184sm21764462pfa.39.2020.03.02.09.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 09:40:20 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 1/2] Documentation: Add a new .rst file under Documentation
Date:   Mon,  2 Mar 2020 23:09:19 +0530
Message-Id: <20200302173920.24626-2-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302173920.24626-1-pragat.pandya@gmail.com>
References: <20200302173920.24626-1-pragat.pandya@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add io_mapping.rst under Documentation and reference it in TOCTree of
index.rst to include it in html documentation.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 Documentation/index.rst                       |   1 +
 .../{io-mapping.txt => io_mapping.rst}        |   0
 doc_make.log                                  | 372 ++++++++++++++++++
 3 files changed, 373 insertions(+)
 rename Documentation/{io-mapping.txt => io_mapping.rst} (100%)
 create mode 100644 doc_make.log

diff --git a/Documentation/index.rst b/Documentation/index.rst
index e99d0bd2589d..14670f2eaa33 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -141,6 +141,7 @@ Architecture-agnostic documentation
    :maxdepth: 2
 
    asm-annotations
+   io_mapping
 
 Architecture-specific documentation
 -----------------------------------
diff --git a/Documentation/io-mapping.txt b/Documentation/io_mapping.rst
similarity index 100%
rename from Documentation/io-mapping.txt
rename to Documentation/io_mapping.rst
diff --git a/doc_make.log b/doc_make.log
new file mode 100644
index 000000000000..b3b86aff2484
--- /dev/null
+++ b/doc_make.log
@@ -0,0 +1,372 @@
+  SPHINX  htmldocs --> file:///home/pragat/Documents/linux_work/mainline/Documentation/output
+  PARSE   include/uapi/linux/dvb/audio.h
+  PARSE   include/uapi/linux/dvb/ca.h
+  PARSE   include/uapi/linux/dvb/dmx.h
+  PARSE   include/uapi/linux/dvb/frontend.h
+  PARSE   include/uapi/linux/dvb/net.h
+  PARSE   include/uapi/linux/dvb/video.h
+  PARSE   include/uapi/linux/videodev2.h
+  PARSE   include/uapi/linux/media.h
+  PARSE   include/uapi/linux/cec.h
+  PARSE   include/uapi/linux/lirc.h
+Running Sphinx v1.8.5
+enabling CJK for LaTeX builder
+building [mo]: targets for 0 po files that are out of date
+building [html]: targets for 2216 source files that are out of date
+updating environment: 2216 added, 0 changed, 0 removed
+reading sources... [  2%] PCI/acpi-info .. admin-guide/auxdisplay/cfag12864b
+Warning: The Sphinx 'sphinx_rtd_theme' HTML theme was not found. Make sure you have the theme installed to produce pretty HTML output. Falling back to the default theme.
+reading sources... [  4%] admin-guide/auxdisplay/index .. admin-guide/device-mapper/dm-init
+reading sources... [  6%] admin-guide/device-mapper/dm-integrity .. admin-guide/laptops/laptop-mode
+reading sources... [  9%] admin-guide/laptops/lg-laptop .. admin-guide/pm/intel_epb
+reading sources... [ 11%] admin-guide/pm/intel_idle .. arm/nwfpe/index
+reading sources... [ 13%] arm/nwfpe/netwinder-fpe .. arm64/acpi_object_usage
+reading sources... [ 16%] arm64/arm-acpi .. core-api/gcc-plugins
+reading sources... [ 18%] core-api/genalloc .. dev-tools/kunit/kunit-tool
+reading sources... [ 20%] dev-tools/kunit/start .. driver-api/edid
+reading sources... [ 23%] driver-api/eisa .. driver-api/libata
+reading sources... [ 25%] driver-api/lightnvm-pblk .. driver-api/pti_intel_mid
+reading sources... [ 27%] driver-api/ptp .. driver-api/usb/error-codes
+reading sources... [ 30%] driver-api/usb/gadget .. fb/sstfb
+reading sources... [ 32%] fb/tgafb .. firmware-guide/acpi/aml-debugger
+reading sources... [ 34%] firmware-guide/acpi/apei/einj .. hid/hiddev
+reading sources... [ 37%] hid/hidraw .. hwmon/ibmaem
+reading sources... [ 39%] hwmon/ibmpowernv .. hwmon/max31790
+reading sources... [ 41%] hwmon/max34440 .. hwmon/twl4030-madc-hwmon
+reading sources... [ 44%] hwmon/ucd9000 .. i2c/i2c-stub
+reading sources... [ 46%] i2c/i2c-topology .. input/devices/ntrig
+reading sources... [ 48%] input/devices/pxrc .. leds/ledtrig-oneshot
+reading sources... [ 51%] leds/ledtrig-transient .. media/kapi/dtv-demux
+reading sources... [ 53%] media/kapi/dtv-frontend .. media/uapi/dvb/audio-fwrite
+reading sources... [ 55%] media/uapi/dvb/audio-get-capabilities .. media/uapi/dvb/dvbapi
+reading sources... [ 58%] media/uapi/dvb/dvbproperty .. media/uapi/dvb/video-freeze
+reading sources... [ 60%] media/uapi/dvb/video-fwrite .. media/uapi/rc/lirc-header
+reading sources... [ 62%] media/uapi/rc/lirc-read .. media/uapi/v4l/dmabuf
+reading sources... [ 65%] media/uapi/v4l/dv-timings .. media/uapi/v4l/pixfmt-nv16m
+reading sources... [ 67%] media/uapi/v4l/pixfmt-nv24 .. media/uapi/v4l/planar-apis
+reading sources... [ 69%] media/uapi/v4l/querycap .. media/uapi/v4l/vidioc-g-fbuf
+reading sources... [ 72%] media/uapi/v4l/vidioc-g-fmt .. media/v4l-drivers/ipu3
+reading sources... [ 74%] media/v4l-drivers/ivtv .. networking/bridge
+reading sources... [ 76%] networking/caif/caif .. networking/dsa/lan9303
+reading sources... [ 79%] networking/dsa/sja1105 .. power/s2ram
+reading sources... [ 81%] power/suspend-and-cpuhotplug .. process/embargoed-hardware-issues
+reading sources... [ 83%] process/howto .. security/keys/index
+reading sources... [ 86%] security/keys/request-key .. sound/soc/dai
+reading sources... [ 88%] sound/soc/dapm .. trace/tracepoint-analysis
+reading sources... [ 90%] trace/tracepoints .. translations/ja_JP/index
+reading sources... [ 93%] translations/ko_KR/howto .. usb/usb-help
+reading sources... [ 95%] usb/usb-serial .. vm/frontswap
+reading sources... [ 97%] vm/highmem .. x86/earlyprintk
+reading sources... [100%] x86/entry_64 .. xtensa/mmu
+
+waiting for workers...
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'quotactl' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'quota_on' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_free_mnt_opts' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_eat_lsm_opts' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_kern_mount' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_show_options' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_add_mnt_opt' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'd_instantiate' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'getprocattr' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'setprocattr' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'locked_down' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_open' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_alloc' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_free' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_read' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_write' not described in 'security_list_options'
+./include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
+./include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'
+./include/kunit/test.h:240: warning: Excess function parameter 'suites' description in 'kunit_test_suites'
+./drivers/usb/typec/bus.c:1: warning: 'typec_altmode_register_driver' not found
+./drivers/usb/typec/bus.c:1: warning: 'typec_altmode_unregister_driver' not found
+./drivers/usb/typec/class.c:1: warning: 'typec_altmode_register_notifier' not found
+./drivers/usb/typec/class.c:1: warning: 'typec_altmode_unregister_notifier' not found
+./include/linux/regulator/machine.h:196: warning: Function parameter or member 'max_uV_step' not described in 'regulation_constraints'
+./include/linux/regulator/driver.h:223: warning: Function parameter or member 'resume' not described in 'regulator_ops'
+./include/linux/spi/spi.h:207: warning: Function parameter or member 'driver_override' not described in 'spi_device'
+./include/linux/spi/spi.h:658: warning: Function parameter or member 'irq_flags' not described in 'spi_controller'
+./drivers/infiniband/core/umem_odp.c:161: warning: Function parameter or member 'ops' not described in 'ib_umem_odp_alloc_child'
+./drivers/infiniband/core/umem_odp.c:211: warning: Function parameter or member 'ops' not described in 'ib_umem_odp_get'
+./drivers/infiniband/ulp/iser/iscsi_iser.h:401: warning: Function parameter or member 'all_list' not described in 'iser_fr_desc'
+./drivers/infiniband/ulp/iser/iscsi_iser.h:415: warning: Function parameter or member 'all_list' not described in 'iser_fr_pool'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd0' not described in 'opa_vesw_info'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd1' not described in 'opa_vesw_info'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd2' not described in 'opa_vesw_info'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd3' not described in 'opa_vesw_info'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd4' not described in 'opa_vesw_info'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function parameter or member 'rsvd0' not described in 'opa_per_veswport_info'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function parameter or member 'rsvd1' not described in 'opa_per_veswport_info'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function parameter or member 'rsvd2' not described in 'opa_per_veswport_info'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function parameter or member 'rsvd3' not described in 'opa_per_veswport_info'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:263: warning: Function parameter or member 'tbl_entries' not described in 'opa_veswport_mactable'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:342: warning: Function parameter or member 'reserved' not described in 'opa_veswport_summary_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd0' not described in 'opa_veswport_error_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd1' not described in 'opa_veswport_error_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd2' not described in 'opa_veswport_error_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd3' not described in 'opa_veswport_error_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd4' not described in 'opa_veswport_error_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd5' not described in 'opa_veswport_error_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd6' not described in 'opa_veswport_error_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd7' not described in 'opa_veswport_error_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd8' not described in 'opa_veswport_error_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd9' not described in 'opa_veswport_error_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:460: warning: Function parameter or member 'reserved' not described in 'opa_vnic_vema_mad'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:485: warning: Function parameter or member 'reserved' not described in 'opa_vnic_notice_attr'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:500: warning: Function parameter or member 'reserved' not described in 'opa_vnic_vema_mad_trap'
+./include/linux/input/sparse-keymap.h:43: warning: Function parameter or member 'sw' not described in 'key_entry'
+./drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:92: warning: Function parameter or member 'vm' not described in 'amdgpu_vm_eviction_lock'
+./drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:1: warning: no structured comments found
+./drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1: warning: no structured comments found
+./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:305: warning: Function parameter or member 'hdcp_workqueue' not described in 'amdgpu_display_manager'
+./include/drm/drm_modeset_helper_vtables.h:1052: warning: Function parameter or member 'prepare_writeback_job' not described in 'drm_connector_helper_funcs'
+./include/drm/drm_modeset_helper_vtables.h:1052: warning: Function parameter or member 'cleanup_writeback_job' not described in 'drm_connector_helper_funcs'
+./drivers/gpu/drm/bridge/panel.c:303: warning: Function parameter or member 'bridge' not described in 'drm_panel_bridge_connector'
+./include/drm/drm_dp_mst_helper.h:162: warning: Function parameter or member 'fec_capable' not described in 'drm_dp_mst_port'
+./include/drm/gpu_scheduler.h:103: warning: Function parameter or member 'priority' not described in 'drm_sched_entity'
+./drivers/gpu/drm/i915/i915_vma.h:1: warning: 'Virtual Memory Address' not found
+./drivers/gpu/drm/i915/i915_gem_gtt.c:1: warning: 'Global GTT views' not found
+./include/linux/host1x.h:66: warning: Function parameter or member 'parent' not described in 'host1x_client'
+./include/linux/host1x.h:66: warning: Function parameter or member 'usecount' not described in 'host1x_client'
+./include/linux/host1x.h:66: warning: Function parameter or member 'lock' not described in 'host1x_client'
+./include/net/cfg80211.h:1189: warning: Function parameter or member 'txpwr' not described in 'station_parameters'
+./include/net/mac80211.h:4080: warning: Function parameter or member 'sta_set_txpwr' not described in 'ieee80211_ops'
+./include/net/mac80211.h:2035: warning: Function parameter or member 'txpwr' not described in 'ieee80211_sta'
+/home/pragat/Documents/linux_work/mainline/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst:142: WARNING: duplicate label virt_mechanism, other instance in /home/pragat/Documents/linux_work/mainline/Documentation/admin-guide/hw-vuln/mds.rst
+/home/pragat/Documents/linux_work/mainline/Documentation/admin-guide/perf/imx-ddr.rst:47: WARNING: Unexpected indentation.
+/home/pragat/Documents/linux_work/mainline/Documentation/admin-guide/bootconfig.rst:26: WARNING: Literal block expected; none found.
+/home/pragat/Documents/linux_work/mainline/Documentation/admin-guide/acpi/fan_performance_states.rst:21: WARNING: Literal block ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/admin-guide/acpi/fan_performance_states.rst:41: WARNING: Literal block expected; none found.
+/home/pragat/Documents/linux_work/mainline/Documentation/admin-guide/ras.rst:358: WARNING: Definition list ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/admin-guide/ras.rst:358: WARNING: Definition list ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/admin-guide/ras.rst:363: WARNING: Definition list ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/admin-guide/ras.rst:363: WARNING: Definition list ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:589: WARNING: Definition list ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:620: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:623: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:626: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:703: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:697: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:722: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:775: WARNING: Definition list ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:814: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:817: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:820: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:823: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:826: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:829: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:832: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:844: WARNING: Unexpected indentation.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:845: WARNING: Block quote ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:849: WARNING: Unexpected indentation.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:850: WARNING: Block quote ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:883: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:886: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:889: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:895: WARNING: Bullet list ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:895: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/trace/events.rst:968: WARNING: Inline emphasis start-string without end-string.
+./drivers/net/phy/sfp-bus.c:579: WARNING: Unexpected indentation.
+./drivers/net/phy/sfp-bus.c:619: WARNING: Unexpected indentation.
+./net/core/dev.c:5196: WARNING: Unknown target name: "page_is".
+/home/pragat/Documents/linux_work/mainline/Documentation/power/pm_qos_interface.rst:12: WARNING: Unexpected indentation.
+./lib/bitmap.c:189: WARNING: Unexpected indentation.
+./lib/bitmap.c:190: WARNING: Block quote ends without a blank line; unexpected unindent.
+./lib/bitmap.c:190: WARNING: Unexpected indentation.
+./lib/bitmap.c:191: WARNING: Line block ends without a blank line.
+./kernel/rcu/update.c:65: WARNING: Inline emphasis start-string without end-string.
+./kernel/rcu/update.c:65: WARNING: Inline emphasis start-string without end-string.
+./kernel/rcu/update.c:70: WARNING: Inline emphasis start-string without end-string.
+./kernel/rcu/update.c:82: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/MAINTAINERS:37755: WARNING: Field list ends without a blank line; unexpected unindent.
+./drivers/message/fusion/mptbase.c:5057: WARNING: Definition list ends without a blank line; unexpected unindent.
+./fs/inode.c:1608: WARNING: Inline emphasis start-string without end-string.
+./fs/inode.c:1608: WARNING: Inline emphasis start-string without end-string.
+./fs/inode.c:1614: WARNING: Inline emphasis start-string without end-string.
+./fs/seq_file.c:40: WARNING: Inline strong start-string without end-string.
+./fs/seq_file.c:40: WARNING: Inline strong start-string without end-string.
+./fs/seq_file.c:40: WARNING: Inline strong start-string without end-string.
+./fs/seq_file.c:40: WARNING: Inline strong start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/filesystems/fuse.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/filesystems/ubifs-authentication.rst:94: WARNING: Inline interpreted text or phrase reference start-string without end-string.
+./include/linux/regulator/driver.h:284: WARNING: Unknown target name: "regulator_regmap_x_voltage".
+./include/linux/spi/spi.h:399: WARNING: Unexpected indentation.
+./include/uapi/linux/firewire-cdev.h:312: WARNING: Inline literal start-string without end-string.
+./drivers/firewire/core-transaction.c:606: WARNING: Inline strong start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:425: WARNING: Unexpected indentation.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:423: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:427: WARNING: Block quote ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:429: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:429: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:429: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:433: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:446: WARNING: Unexpected indentation.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:440: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:440: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:447: WARNING: Block quote ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:449: WARNING: Definition list ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:462: WARNING: Unexpected indentation.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:460: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:462: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:465: WARNING: Block quote ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:467: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:467: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:467: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:471: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/gpio/driver.rst:478: WARNING: Inline emphasis start-string without end-string.
+./include/linux/i2c.h:518: WARNING: Inline strong start-string without end-string.
+./drivers/infiniband/core/verbs.c:2583: WARNING: Unexpected indentation.
+./drivers/infiniband/core/verbs.c:2585: WARNING: Block quote ends without a blank line; unexpected unindent.
+./drivers/infiniband/core/verbs.c:2617: WARNING: Unexpected indentation.
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:243: WARNING: Inline strong start-string without end-string.
+./drivers/base/platform.c:134: WARNING: Unexpected indentation.
+./drivers/base/platform.c:213: WARNING: Unexpected indentation.
+./drivers/ata/libata-core.c:5974: WARNING: Unknown target name: "hw".
+./drivers/gpu/drm/mcde/mcde_drv.c:47: WARNING: Unexpected indentation.
+./drivers/gpu/drm/mcde/mcde_drv.c:49: WARNING: Block quote ends without a blank line; unexpected unindent.
+./include/linux/devfreq.h:156: WARNING: Inline emphasis start-string without end-string.
+./include/linux/devfreq.h:261: WARNING: Inline emphasis start-string without end-string.
+./include/linux/devfreq.h:281: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/dmaengine/client.rst:203: WARNING: Unexpected indentation.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/dmaengine/client.rst:204: WARNING: Block quote ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/dmaengine/client.rst:210: WARNING: Unexpected indentation.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/dmaengine/client.rst:211: WARNING: Block quote ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/dmaengine/client.rst:220: WARNING: Unexpected indentation.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/dmaengine/client.rst:221: WARNING: Block quote ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/dmaengine/client.rst:229: WARNING: Unexpected indentation.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/dmaengine/client.rst:230: WARNING: Block quote ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/dmaengine/provider.rst:270: WARNING: Unexpected indentation.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/dmaengine/provider.rst:273: WARNING: Block quote ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/dmaengine/provider.rst:288: WARNING: Unexpected indentation.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/dmaengine/provider.rst:290: WARNING: Block quote ends without a blank line; unexpected unindent.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/driver-model/driver.rst:215: WARNING: Inline emphasis start-string without end-string.
+/home/pragat/Documents/linux_work/mainline/Documentation/driver-api/driver-model/driver.rst:215: WARNING: Inline emphasis start-string without end-string.
+looking for now-outdated files... none found
+pickling environment... done
+checking consistency... /home/pragat/Documents/linux_work/mainline/Documentation/driver-api/thermal/cpu-idle-cooling.rst: WARNING: document isn't included in any toctree
+done
+preparing documents... done
+writing output... [  2%] PCI/endpoint/index .. admin-guide/binfmt-misc
+writing output... [  5%] admin-guide/blockdev/drbd/data-structure-v9 .. admin-guide/device-mapper/era
+writing output... [  7%] admin-guide/device-mapper/index .. admin-guide/mm/idle_page_tracking
+writing output... [ 10%] admin-guide/mm/index .. admin-guide/sysctl/fs
+writing output... [ 12%] admin-guide/sysctl/index .. arm/samsung-s3c24xx/nand
+writing output... [ 15%] arm/samsung-s3c24xx/overview .. block/null_blk
+writing output... [ 17%] block/pr .. crypto/api-kpp
+./include/linux/slab.h:503: WARNING: undefined label: memory-allocation (if the link has no caption the label must precede a section header)
+writing output... [ 20%] crypto/api-rng .. driver-api/dmaengine/dmatest
+writing output... [ 22%] driver-api/dmaengine/index .. driver-api/iio/buffers
+writing output... [ 25%] driver-api/iio/core .. driver-api/pci/pci
+writing output... [ 27%] driver-api/phy/index .. driver-api/uio-howto
+writing output... [ 30%] driver-api/usb/URB .. fb/sisfb
+writing output... [ 32%] fb/sm501 .. firmware-guide/acpi/apei/einj
+writing output... [ 35%] firmware-guide/acpi/apei/output_format .. hwmon/ab8500
+writing output... [ 37%] hwmon/abituguru .. hwmon/isl68137
+writing output... [ 40%] hwmon/it87 .. hwmon/nct7802
+writing output... [ 42%] hwmon/nct7904 .. hwmon/wm831x
+writing output... [ 45%] hwmon/wm8350 .. ia64/serial
+writing output... [ 47%] ia64/xen .. isdn/index
+writing output... [ 50%] isdn/interface_capi .. media/cec-drivers/pulse8-cec
+writing output... [ 52%] media/dvb-drivers/avermedia .. media/uapi/cec/cec-func-poll
+writing output... [ 55%] media/uapi/cec/cec-funcs .. media/uapi/dvb/dmx-munmap
+writing output... [ 57%] media/uapi/dvb/dmx-qbuf .. media/uapi/dvb/net-get-if
+writing output... [ 60%] media/uapi/dvb/net-remove-if .. media/uapi/rc/lirc-dev-intro
+writing output... [ 62%] media/uapi/rc/lirc-func .. media/uapi/v4l/dev-touch
+writing output... [ 65%] media/uapi/v4l/devices .. media/uapi/v4l/pixfmt-nv24
+writing output... [ 67%] media/uapi/v4l/pixfmt-packed-hsv .. media/uapi/v4l/selection-api-configuration
+writing output... [ 70%] media/uapi/v4l/selection-api-examples .. media/uapi/v4l/vidioc-g-selection
+writing output... [ 72%] media/uapi/v4l/vidioc-g-sliced-vbi-cap .. media/v4l-drivers/saa7134
+writing output... [ 75%] media/v4l-drivers/saa7134-cardlist .. networking/device_drivers/intel/iavf
+writing output... [ 77%] networking/device_drivers/intel/ice .. nios2/nios2
+writing output... [ 80%] nvdimm/maintainer-entry-profile .. powerpc/papr_hcalls
+writing output... [ 82%] powerpc/pci_iov_resource_on_powernv .. s390/s390dbf
+writing output... [ 85%] s390/text_files .. sound/designs/jack-controls
+writing output... [ 87%] sound/designs/oss-emulation .. trace/events-kmem
+writing output... [ 90%] trace/events-msr .. translations/it_IT/process/magic-number
+writing output... [ 92%] translations/it_IT/process/maintainer-pgp-guide .. usb/index
+writing output... [ 95%] usb/iuu_phoenix .. vm/active_mm
+writing output... [ 97%] vm/balance .. x86/entry_64
+writing output... [100%] x86/exception-tables .. xtensa/mmu
+
+waiting for workers...
+generating indices... genindex
+writing additional pages... search
+copying images... [  1%] RCU/Design/Data-Structures/BigTreeClassicRCU.svg
+copying images... [  2%] RCU/Design/Data-Structures/HugeTreeClassicRCU.svg
+copying images... [  4%] RCU/Design/Data-Structures/BigTreePreemptRCUBHdyntickCB.svg
+copying images... [  5%] RCU/Design/Data-Structures/TreeMapping.svg
+copying images... [  7%] RCU/Design/Data-Structures/TreeMappingLevel.svg
+copying images... [  8%] RCU/Design/Data-Structures/TreeLevel.svg
+copying images... [ 10%] RCU/Design/Data-Structures/blkd_task.svg
+copying images... [ 11%] RCU/Design/Data-Structures/nxtlist.svg
+copying images... [ 12%] RCU/Design/Expedited-Grace-Periods/ExpRCUFlow.svg
+copying images... [ 14%] RCU/Design/Expedited-Grace-Periods/ExpSchedFlow.svg
+copying images... [ 15%] RCU/Design/Expedited-Grace-Periods/Funnel0.svg
+copying images... [ 17%] RCU/Design/Expedited-Grace-Periods/Funnel1.svg
+copying images... [ 18%] RCU/Design/Expedited-Grace-Periods/Funnel2.svg
+copying images... [ 20%] RCU/Design/Expedited-Grace-Periods/Funnel3.svg
+copying images... [ 21%] RCU/Design/Expedited-Grace-Periods/Funnel4.svg
+copying images... [ 22%] RCU/Design/Expedited-Grace-Periods/Funnel5.svg
+copying images... [ 24%] RCU/Design/Expedited-Grace-Periods/Funnel6.svg
+copying images... [ 25%] RCU/Design/Expedited-Grace-Periods/Funnel7.svg
+copying images... [ 27%] RCU/Design/Expedited-Grace-Periods/Funnel8.svg
+copying images... [ 28%] RCU/Design/Memory-Ordering/rcu_node-lock.svg
+copying images... [ 30%] RCU/Design/Memory-Ordering/TreeRCU-callback-registry.svg
+copying images... [ 31%] RCU/Design/Memory-Ordering/TreeRCU-gp-init-1.svg
+copying images... [ 32%] RCU/Design/Memory-Ordering/TreeRCU-qs.svg
+copying images... [ 34%] RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
+copying images... [ 35%] RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
+copying images... [ 37%] RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
+copying images... [ 38%] RCU/Design/Memory-Ordering/TreeRCU-gp-cleanup.svg
+copying images... [ 40%] RCU/Design/Memory-Ordering/TreeRCU-callback-invocation.svg
+copying images... [ 41%] RCU/Design/Memory-Ordering/TreeRCU-gp.svg
+copying images... [ 42%] RCU/Design/Requirements/GPpartitionReaders1.svg
+copying images... [ 44%] RCU/Design/Requirements/ReadersPartitionGP1.svg
+copying images... [ 45%] admin-guide/blockdev/drbd/DRBD-8.3-data-packets.svg
+copying images... [ 47%] admin-guide/blockdev/drbd/DRBD-data-packets.svg
+copying images... [ 48%] admin-guide/blockdev/drbd/conn-states-8.dot
+copying images... [ 50%] admin-guide/blockdev/drbd/disk-states-8.dot
+copying images... [ 51%] admin-guide/blockdev/drbd/node-states-8.dot
+copying images... [ 52%] doc-guide/svg_image.svg
+copying images... [ 54%] doc-guide/hello.dot
+copying images... [ 55%] gpu/dp-mst/topology-figure-1.dot
+copying images... [ 57%] gpu/dp-mst/topology-figure-2.dot
+copying images... [ 58%] gpu/dp-mst/topology-figure-3.dot
+copying images... [ 60%] i2c/i2c.svg
+copying images... [ 61%] input/shape.svg
+copying images... [ 62%] input/interactive.svg
+copying images... [ 64%] media/typical_media_device.svg
+copying images... [ 65%] media/uapi/dvb/dvbstb.svg
+copying images... [ 67%] media/uapi/v4l/crop.svg
+copying images... [ 68%] media/uapi/v4l/vbi_hsync.svg
+copying images... [ 70%] media/uapi/v4l/vbi_525.svg
+copying images... [ 71%] media/uapi/v4l/vbi_625.svg
+copying images... [ 72%] media/uapi/v4l/pipeline.dot
+copying images... [ 74%] media/uapi/v4l/subdev-image-processing-crop.svg
+copying images... [ 75%] media/uapi/v4l/subdev-image-processing-scaling-multi-source.svg
+copying images... [ 77%] media/uapi/v4l/subdev-image-processing-full.svg
+copying images... [ 78%] media/uapi/v4l/fieldseq_tb.svg
+copying images... [ 80%] media/uapi/v4l/fieldseq_bt.svg
+copying images... [ 81%] media/uapi/v4l/nv12mt.svg
+copying images... [ 82%] media/uapi/v4l/nv12mt_example.svg
+copying images... [ 84%] media/uapi/v4l/selection.svg
+copying images... [ 85%] media/uapi/v4l/bayer.svg
+copying images... [ 87%] media/uapi/v4l/constraints.svg
+copying images... [ 88%] media/v4l-drivers/ipu3_rcb.svg
+copying images... [ 90%] media/v4l-drivers/qcom_camss_graph.dot
+copying images... [ 91%] media/v4l-drivers/qcom_camss_8x96_graph.dot
+copying images... [ 92%] media/v4l-drivers/vimc.dot
+copying images... [ 94%] networking/tls-offload-layers.svg
+copying images... [ 95%] networking/tls-offload-reorder-good.svg
+copying images... [ 97%] networking/tls-offload-reorder-bad.svg
+copying images... [ 98%] translations/it_IT/doc-guide/../../../doc-guide/svg_image.svg
+copying images... [100%] translations/it_IT/doc-guide/../../../doc-guide/hello.dot
+
+copying static files... done
+copying extra files... done
+dumping search index in English (code: en) ... done
+dumping object inventory... done
+build succeeded, 111 warnings.
+
+The HTML pages are in Documentation/output.
-- 
2.17.1

