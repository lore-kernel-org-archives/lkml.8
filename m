Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA80C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9018E2072F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="N1oZXmlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgFCDnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 23:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgFCDnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:43:07 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34F5C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 20:43:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id y18so333925plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 20:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=9P/rcqRUtdDUZHzz06EtqoOTWuT5t5v5LhPilPpI8U8=;
        b=N1oZXmlKlPtvXVVjxKDiVzbJ0joI+5Jp5WpZ3BwWTgYD5wdIJYf6UyRLaZLlYTUr8K
         mJ5Lhi8jNSclZygZvSZq4CbtkRh9945remBLkgjo7Yc3EjXAd98VMeoNFizz+MTYN/0N
         XrK9Rix8jyPqPI4+Xj0Lyo6QzfZb2wLdiF1hgAzXhFYtR8uPXafDxK1ImcmhLp8azroF
         PgrEreVc2oA5ZHdCeOoxFcTq5xpPit2fEqA02O5v/HuZ0oT+hY9EkbPPXeOrDQqt8oAU
         njN/+yKHvcfh0W3l6oyqEUOiQf9n5m6NVy53ooBFzk6DvYfbn0IecuzodDQo49tepLFb
         0OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=9P/rcqRUtdDUZHzz06EtqoOTWuT5t5v5LhPilPpI8U8=;
        b=ecyDPncH0zDDtoj8o1UFIDqSkOcH309nmv56QvHs8/Ip919p3FsVdBCoCwcH6bmuMz
         p2AXVN2lMfW9VCbbcwkl9QHnBAlmvaO1h8vwd/HeVvFHU9iQXHYGH5HP40n9TpIJ+tQ5
         ObmEVaDQ66gfAxUVvSl3XaiFWkIirqdRD+JVoBRJ78V3wZJmo4PF2+TypWBEZT8nJ7oO
         EWQBSdrz+o1d1AQiGnQn97vTfM1xAzgw1oI7LFe3Uf/c7KEk8hb4SQTTIiOclmWeQSLP
         QtFRPi9SUkkumPpsZUzfuoX5Y1O7B96vQzyHlrwdXwpWtJCRWj7peOXtmQ/fhjEOwDJx
         q7Aw==
X-Gm-Message-State: AOAM531uGoh8c3+n/oX+aqXFiG+Njq6KozRzVyjMFFVi7EIvZacv/geg
        fH++M9Sgfe/93wHNSizBEdQLkg==
X-Google-Smtp-Source: ABdhPJybmrm+Q6H26ReKaf3vVPeruX+PhPK/7dDrTEPusjijqkxEdsA4dNIajMIoLampINICppzabg==
X-Received: by 2002:a17:902:b68f:: with SMTP id c15mr28461138pls.303.1591155786736;
        Tue, 02 Jun 2020 20:43:06 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id m7sm502220pfb.1.2020.06.02.20.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 20:43:06 -0700 (PDT)
Date:   Tue, 2 Jun 2020 20:42:58 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] iproute2-5.7.0 release
Message-ID: <20200602204258.717259c5@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 5.7 kernel has been released, and the last patches have
been applied to iproute2.

As usual lots of small fixes, across many utilities.
Several qdisc now have more parameters available.
Devlink get most of the fixes.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-5.7.0.tar.=
gz

Repository for upcoming release:
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Thanks for all the contributions.

Report problems (or enhancements) to the netdev@vger.kernel.org mailing lis=
t.


Andrea Claudi (2):
      Revert "bpf: replace snprintf with asprintf when dealing with long bu=
ffers"
      bpf: Fixes a snprintf truncation warning

Antoine Tenart (4):
      macsec: report the offloading mode currently selected
      macsec: add support for changing the offloading mode
      man: document the ip macsec offload command
      macsec: add an accessor for validate_str

Bastien Roucari=C3=A8s (6):
      Better documentation of mcast_to_unicast option
      Improve hairpin mode description
      Document BPDU filter option
      Better documentation of BDPU guard
      Document root_block option
      State of bridge STP port are now case insensitive

Benjamin Lee (4):
      man: tc-htb.8: add missing qdisc parameter r2q
      man: tc-htb.8: add missing class parameter quantum
      man: tc-htb.8: fix class prio is not mandatory
      tc: fq_codel: fix class stat deficit is signed int

Benjamin Poirier (6):
      bridge: Use consistent column names in vlan output
      bridge: Fix typo
      bridge: Fix output with empty vlan lists
      json_print: Return number of characters printed
      bridge: Align output columns
      Replace open-coded instances of print_nl()

Brian Norris (2):
      man: add ip-netns(8) as generation target
      man: replace $(NETNS_ETC_DIR) and $(NETNS_RUN_DIR) in ip-netns(8)

Danielle Ratson (1):
      bash-completion: devlink: add bash-completion function

David Ahern (4):
      Update kernel headers
      Update kernel headers
      Update kernel headers
      Update kernel headers

Donald Sharp (1):
      nexthop: Fix Deletion display

Eric Dumazet (5):
      tc: fq_codel: add drop_batch parameter
      tc: fq: add timer_slack parameter
      ss: add support for Gbit speeds in sprint_bw()
      tc: fq: fix two issues
      utils: remove trailing zeros in print_time() and print_time64()

Ido Schimmel (3):
      devlink: Add devlink trap policer set and show commands
      devlink: Add ability to bind policer to trap group
      bash-completion: devlink: Extend bash-completion for new commands

Jacob Keller (1):
      devlink: add support for DEVLINK_CMD_REGION_NEW

Jakub Kicinski (1):
      tc: m_action: rename hw stats type uAPI

Jiri Pirko (14):
      devlink: add trap metadata type for flow action cookie
      tc: m_action: introduce support for hw stats type
      tc: show used HW stats types
      devlink: remove custom bool command line options parsing
      devlink: Fix help and man of "devlink health set" command
      devlink: fix encap mode manupulation
      devlink: Add alias "counters_enabled" for "counters" option
      devlink: rename dpipe_counters_enable struct field to dpipe_counters_=
enabled
      devlink: Fix help message for dpipe
      devlink: remove "dev" object sub help messages
      man: add man page for devlink dpipe
      devlink: remove unused "jw" field
      devlink: fix JSON output of mon command
      tc: m_action: check cookie hex string len

Leslie Monis (2):
      tc: pie: change maximum integer value of tc_pie_xstats->prob
      Revert "tc: pie: change maximum integer value of tc_pie_xstats->prob"

Moshe Shemesh (1):
      devlink: Add health error recovery status monitoring

Odin Ugedal (3):
      tc_util: detect overflow in get_size
      q_cake: Make fwmark uint instead of int
      q_cake: properly print memlimit

Parav Pandit (1):
      devlink: Introduce devlink port flavour virtual

Paul Blakey (1):
      man: tc-ct.8: Add manual page for ct tc action

Petr Machata (5):
      tc: q_red: Support 'nodrop' flag
      tc: p_ip6: Support pedit of IPv6 dsfield
      man: tc-pedit: Add examples for dsfield and retain
      man: tc-pedit: Drop the claim that pedit ex is only for IPv4
      ip: link_gre: Do not send ERSPAN attributes to GRE tunnels

Roman Mashak (1):
      tc: action: fix time values output in JSON format

Stephen Hemminger (7):
      man/tc-actions: fix formatting
      bridge: man page spelling fixes
      uapi: update bpf.h
      ss: update to bw print
      uapi: update to bpf.h
      uapi: fix comment in xfrm.h
      v5.7.0

Xin Long (1):
      xfrm: also check for ipv6 state in xfrm_state_keep

