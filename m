Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C3BC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5794C20873
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgBKJs1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:48:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:40515 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgBKJs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:48:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 01:48:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="226459019"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga007.fm.intel.com with ESMTP; 11 Feb 2020 01:48:23 -0800
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Feb 2020 01:48:22 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.126]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.5]) with mapi id 14.03.0439.000;
 Tue, 11 Feb 2020 17:48:21 +0800
From:   "Li, Philip" <philip.li@intel.com>
To:     lkp <lkp@intel.com>, Michal Kubecek <mkubecek@suse.cz>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Florian Fainelli" <f.fainelli@gmail.com>
Subject: RE: [kbuild-all] powerpc64-linux-ld: warning: orphan section
 `.ctors.65435' from `net/ethtool/linkmodes.o' being placed in section
 `.ctors.65435'.
Thread-Topic: [kbuild-all] powerpc64-linux-ld: warning: orphan section
 `.ctors.65435' from `net/ethtool/linkmodes.o' being placed in section
 `.ctors.65435'.
Thread-Index: AQHV4LybZyDnSM26/EStnRdm99VWnKgVvxWA
Date:   Tue, 11 Feb 2020 09:48:19 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E66249523A5211@shsmsx102.ccr.corp.intel.com>
References: <202002111711.7PSCFEuy%lkp@intel.com>
In-Reply-To: <202002111711.7PSCFEuy%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [kbuild-all] powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ethtool/linkmodes.o' being placed in section `.ctors.65435'.
sorry, kindly ignore this reported warning, which will be blacklisted.

> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0a679e13ea30f85a1aef0669ee0c5a9fd7860b34
> commit: f625aa9be8c10f2e4dc677837e240730a25feda7 ethtool: provide link mode
> information with LINKMODES_GET request
> date:   6 weeks ago
> config: powerpc-randconfig-a001-20200209 (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-
> tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout f625aa9be8c10f2e4dc677837e240730a25feda7
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=powerpc
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/pressure/dps310.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/pressure/hid-sensor-press.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/pressure/hp03.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/pressure/mpl3115.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/pressure/ms5611_core.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/pressure/t5403.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/pressure/hp206c.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/proximity/isl29501.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/proximity/pulsedlight-lidar-lite-v2.o' being placed in section
> `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/proximity/srf08.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/proximity/sx9500.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/proximity/vl53l0x-i2c.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/trigger/iio-trig-sysfs.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/mcb/mcb-core.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/mcb/mcb-parse.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/hwtracing/intel_th/core.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/hwtracing/intel_th/debug.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/hwtracing/intel_th/pti.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/hwtracing/stm/core.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/hwtracing/stm/policy.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/hwtracing/stm/dummy_stm.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/hwtracing/stm/console.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/hwtracing/stm/heartbeat.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/nvmem/core.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/nvmem/nvmem-sysfs.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/mux/core.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/siox/siox-core.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/siox/siox-bus-gpio.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/socket.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/sock.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/request_sock.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/skbuff.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/datagram.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/stream.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/core/scm.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/gen_stats.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/gen_estimator.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/net_namespace.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/secure_seq.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/flow_dissector.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/sysctl_net_core.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/core/dev.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/dev_addr_lists.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/core/dst.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/netevent.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/neighbour.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/rtnetlink.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/core/utils.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/link_watch.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/filter.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/sock_diag.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/dev_ioctl.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/core/tso.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/sock_reuseport.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/fib_notifier.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/core/xdp.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/flow_offload.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/core/net-
> sysfs.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/core/net-
> procfs.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/skmsg.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/fib_rules.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/core/net-
> traces.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/ptp_classifier.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/netprio_cgroup.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/netclassid_cgroup.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/lwtunnel.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/lwt_bpf.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/sock_map.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/dst_cache.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/gro_cells.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/failover.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/bpf_sk_storage.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/compat.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ethernet/eth.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_generic.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_mq.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_api.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_blackhole.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/cls_api.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_fifo.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_sfq.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_prio.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_multiq.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_drr.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_mqprio.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_qfq.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_hhf.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_pie.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_etf.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/cls_tcindex.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/cls_rsvp6.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/netlink/af_netlink.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/netlink/genetlink.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/bpf/test_run.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ethtool/ioctl.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ethtool/common.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ethtool/netlink.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ethtool/bitset.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ethtool/strset.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ethtool/linkinfo.o' being placed in section `.ctors.65435'.
> >> powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ethtool/linkmodes.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/route.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/inetpeer.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/protocol.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/ip_input.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/ip_fragment.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/ip_forward.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/ip_options.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/ip_output.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/ip_sockglue.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/inet_hashtables.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/inet_timewait_sock.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/inet_connection_sock.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ipv4/tcp.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_input.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_output.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_timer.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_ipv4.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_minisocks.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_cong.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_metrics.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_fastopen.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_rate.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_recovery.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_ulp.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_offload.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/datagram.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ipv4/raw.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ipv4/udp.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/udplite.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/udp_offload.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ipv4/arp.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/icmp.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/devinet.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/af_inet.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/igmp.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/fib_frontend.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/fib_semantics.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/fib_trie.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/fib_notifier.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/inet_fragment.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ipv4/ping.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/ip_tunnel_core.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/gre_offload.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/metrics.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/netlink.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/nexthop.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/ip_tunnel.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/sysctl_net_ipv4.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ipv4/proc.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/fib_rules.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ipv4/fou.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/udp_tunnel.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tunnel4.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/ipconfig.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/inet_diag.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_diag.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_cubic.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_bpf.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/xfrm4_policy.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/xfrm4_state.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/xfrm4_input.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/xfrm4_output.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/xfrm4_protocol.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/xfrm/xfrm_policy.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/xfrm/xfrm_state.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/xfrm/xfrm_hash.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/xfrm/xfrm_input.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/xfrm/xfrm_output.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/xfrm/xfrm_sysctl.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/xfrm/xfrm_replay.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/xfrm/xfrm_device.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/unix/af_unix.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/unix/garbage.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/unix/sysctl_net_unix.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/unix/scm.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/af_inet6.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/anycast.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/ip6_output.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/ip6_input.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/addrconf.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/addrlabel.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/route.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/ip6_fib.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/ipv6_sockglue.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/ndisc.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ipv6/udp.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/udplite.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ipv6/raw.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/icmp.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/mcast.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/reassembly.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/tcp_ipv6.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ipv6/ping.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/exthdrs.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/datagram.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/ip6_flowlabel.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/inet6_connection_sock.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/udp_offload.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/seg6.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/fib6_notifier.o' being placed in section `.ctors.65435'.
> --
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/pressure/dps310.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/pressure/hid-sensor-press.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/pressure/hp03.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/pressure/mpl3115.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/pressure/ms5611_core.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/pressure/t5403.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/pressure/hp206c.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/proximity/isl29501.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/proximity/pulsedlight-lidar-lite-v2.o' being placed in section
> `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/proximity/srf08.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/proximity/sx9500.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/proximity/vl53l0x-i2c.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/iio/trigger/iio-trig-sysfs.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/mcb/mcb-core.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/mcb/mcb-parse.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/hwtracing/intel_th/core.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/hwtracing/intel_th/debug.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/hwtracing/intel_th/pti.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/hwtracing/stm/core.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/hwtracing/stm/policy.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/hwtracing/stm/dummy_stm.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/hwtracing/stm/console.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/hwtracing/stm/heartbeat.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/nvmem/core.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/nvmem/nvmem-sysfs.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/mux/core.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/siox/siox-core.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `drivers/siox/siox-bus-gpio.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/socket.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/sock.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/request_sock.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/skbuff.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/datagram.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/stream.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/core/scm.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/gen_stats.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/gen_estimator.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/net_namespace.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/secure_seq.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/flow_dissector.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/sysctl_net_core.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/core/dev.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/dev_addr_lists.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/core/dst.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/netevent.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/neighbour.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/rtnetlink.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/core/utils.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/link_watch.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/filter.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/sock_diag.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/dev_ioctl.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/core/tso.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/sock_reuseport.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/fib_notifier.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/core/xdp.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/flow_offload.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/core/net-
> sysfs.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/core/net-
> procfs.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/skmsg.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/fib_rules.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/core/net-
> traces.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/ptp_classifier.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/netprio_cgroup.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/netclassid_cgroup.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/lwtunnel.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/lwt_bpf.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/sock_map.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/dst_cache.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/gro_cells.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/failover.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/core/bpf_sk_storage.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/compat.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ethernet/eth.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_generic.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_mq.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_api.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_blackhole.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/cls_api.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_fifo.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_sfq.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_prio.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_multiq.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_drr.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_mqprio.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_qfq.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_hhf.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_pie.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/sch_etf.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/cls_tcindex.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/sched/cls_rsvp6.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/netlink/af_netlink.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/netlink/genetlink.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/bpf/test_run.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ethtool/ioctl.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ethtool/common.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ethtool/netlink.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ethtool/bitset.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ethtool/strset.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ethtool/linkinfo.o' being placed in section `.ctors.65435'.
> >> powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ethtool/linkmodes.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/route.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/inetpeer.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/protocol.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/ip_input.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/ip_fragment.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/ip_forward.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/ip_options.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/ip_output.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/ip_sockglue.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/inet_hashtables.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/inet_timewait_sock.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/inet_connection_sock.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ipv4/tcp.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_input.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_output.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_timer.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_ipv4.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_minisocks.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_cong.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_metrics.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_fastopen.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_rate.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_recovery.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_ulp.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_offload.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/datagram.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ipv4/raw.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ipv4/udp.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/udplite.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/udp_offload.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ipv4/arp.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/icmp.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/devinet.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/af_inet.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/igmp.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/fib_frontend.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/fib_semantics.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/fib_trie.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/fib_notifier.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/inet_fragment.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ipv4/ping.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/ip_tunnel_core.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/gre_offload.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/metrics.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/netlink.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/nexthop.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/ip_tunnel.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/sysctl_net_ipv4.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ipv4/proc.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/fib_rules.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ipv4/fou.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/udp_tunnel.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tunnel4.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/ipconfig.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/inet_diag.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_diag.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_cubic.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/tcp_bpf.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/xfrm4_policy.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/xfrm4_state.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/xfrm4_input.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/xfrm4_output.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv4/xfrm4_protocol.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/xfrm/xfrm_policy.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/xfrm/xfrm_state.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/xfrm/xfrm_hash.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/xfrm/xfrm_input.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/xfrm/xfrm_output.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/xfrm/xfrm_sysctl.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/xfrm/xfrm_replay.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/xfrm/xfrm_device.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/unix/af_unix.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/unix/garbage.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/unix/sysctl_net_unix.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/unix/scm.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/af_inet6.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/anycast.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/ip6_output.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/ip6_input.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/addrconf.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/addrlabel.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/route.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/ip6_fib.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/ipv6_sockglue.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/ndisc.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ipv6/udp.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/udplite.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ipv6/raw.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/icmp.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/mcast.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/reassembly.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/tcp_ipv6.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from `net/ipv6/ping.o'
> being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/exthdrs.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/datagram.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/ip6_flowlabel.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/inet6_connection_sock.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/udp_offload.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/seg6.o' being placed in section `.ctors.65435'.
>    powerpc64-linux-ld: warning: orphan section `.ctors.65435' from
> `net/ipv6/fib6_notifier.o' being placed in section `.ctors.65435'.
> ..
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
