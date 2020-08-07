Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B5AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D59F72075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="g9NXD8HR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgHGP54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 11:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgHGP5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 11:57:55 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3D8C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 08:57:55 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q17so1225369pls.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=eUpvaTqUYrMyWZbq7tEdgtH3MVmHdB0HgoG8WDALDBM=;
        b=g9NXD8HRe/9tWdd5YZ8x9Hmxw3j98KyR/Ixwr2U1JGV+x9ew1ox6djajiVhu+TfrOI
         ABtBAqd9syIkMWXhelhf1W24OajVWIBjq0X9Vh87ZuUwnrykfpvENL9xVOb5ui2LQZel
         p48Cc27jK2ysSbiJfeiD0r7sRlBuvpTYOVhijW/1rH/AJV0jiMHQYFwaWmkhchK9fHtb
         kDUKocyVU+Y4KtxUdnOMzrTYnmQ1OtnbJH9nAZPX7BEwJhOrJeG9mN8jXaDkLp376FBS
         ROyXvwV/77NpGCP/lgBkuBcsYYo860DtMesZnGVGwwLA8RXjcGSe9TcPC0MwilTo0Geb
         1pOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=eUpvaTqUYrMyWZbq7tEdgtH3MVmHdB0HgoG8WDALDBM=;
        b=qwhnV9qJspu6jNZyYbbP5QtJEETTV1gLzcXbg20I3TdfqV4Wt3UJ1AWKYEP3KuGDB3
         FuP8RSE9irykmSYnpXS4DM1UUA9gZeTsBSWRk/z6u1d4NbMzPX0EpxIG7WcY0Ear2dEV
         q4TKKIrXciaxj7EuA0+wKeSLh02mUFYPzzjnodkLv40q05f1fM+Qhz0otjC1y/M8q7q9
         JUwb9p57LbFsjAmVYi6ea9w3v30H7NPqoUUGP03/8krb7vLVofTUv+GL+pX7phjxEOeF
         qMBDMUNNMfMRgwBHDT79dAKs4TfRAWAow2m3Wi3fEq13TDiED8S6Z3oHqoy9jOcIEMow
         67Rw==
X-Gm-Message-State: AOAM530MdSK1Kzlp7armsJbi9HvZQCS7QYsEFJ8PobXuLp1n3YzAEmTJ
        LP2iYPN8DyhuYG2CY6xLNqsTbMgrCFY=
X-Google-Smtp-Source: ABdhPJwvt973ShLNQBXsJ5gTd6aOO23BVnkwbA42vMbpqVpfyb/A98JNGRX5vMHbZxmUGl2coyfQsg==
X-Received: by 2002:a17:902:9309:: with SMTP id bc9mr12418716plb.51.1596815873482;
        Fri, 07 Aug 2020 08:57:53 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id x136sm12851663pfc.28.2020.08.07.08.57.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 08:57:53 -0700 (PDT)
Date:   Fri, 7 Aug 2020 08:57:45 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] iproute2 5.8
Message-ID: <20200807085745.705a0247@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Time for a new version of iproute2 to go with the 5.8 kernel.
There are couple of administrative changes that long term downloaders
will notice. First it that iproute2 is now maintained on the "main"
branch. There are parallel copies (both updated) on kernel.org
and github.

If you use github, you will get the right default branch;
if you use kernel.org you will get the WRONG default branch.
Kernel.org still does not have an way to change the name of the
default branch. The "master" branch is dead and will be
removed once kernel.org is fixed. If you have an existing
iproute2 git repo either or clone a new copy or
see one of many tutorials on renaming the master branch.

The other change is that the former date based internal
versioning (snapshot) is replaced by the regular version numbering
which corresponds to the kernel version. Iproute2
carries its own sanitized version of the kernel headers so the
current code will build and run on older kernel releases.

It is recommended to always use the latest iproute2.
Do not treat iproute2 like perf and require matching packages.
The latest code will always run on older kernels (and vice versa);
this is possible because of the kernel API/ABI guarantees.
Except for rare cases, iproute2 does not do maintenance releases
and there is no long term stable version.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-5.8.0.tar.gz

Repository for current release
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Thanks for all the contributions.

Report problems (or enhancements) to the netdev@vger.kernel.org mailing list.


Alexander Aring (1):
      lwtunnel: add support for rpl segment routing

Andrea Claudi (1):
      ip address: remove useless include

Anton Danilov (3):
      tc: improve the qdisc show command
      misc: make the pattern matching case-insensitive
      bridge: fdb: the 'dynamic' option in the show/get commands

Bjarni Ingi Gislason (5):
      libnetlink.3: display section numbers in roman font, not boldface
      man8/bridge.8: fix misuse of two-fonts macros
      devlink.8: Use a single-font macro for a single argument
      devlink-dev.8: use a single-font macro for one argument
      devlint-health.8: use a single-font macro for a single argument

David Ahern (4):
      Update kernel headers and import mptcp.h
      Update kernel headers
      Import rpl.h and rpl_iptunnel.h uapi headers
      Update kernel headers and import tc_gate.h

Davide Caratti (2):
      ss: allow dumping MPTCP subflow information
      tc: full JSON support for 'bpf' filter

Dmitry Yakunin (4):
      ss: introduce cgroup2 cache and helper functions
      ss: add support for cgroup v2 information and filtering
      ss: add checks for bc filter support
      lib: fix checking of returned file handle size for cgroup

Eran Ben Elisha (1):
      devlink: Add devlink health auto_dump command support

Eyal Birger (2):
      ip xfrm: update man page on setting/printing XFRMA_IF_ID in states/policies
      ip xfrm: policy: support policies with IF_ID in get/delete/deleteall

Guillaume Nault (3):
      ip link: initial support for bareudp devices
      tc: flower: support multiple MPLS LSE match
      testsuite: Add tests for bareudp tunnels

Hoang Huu Le (1):
      tipc: fixed a compile warning in tipc/link.c

Ian K. Coolidge (2):
      iproute2: ip addr: Organize flag properties structurally
      iproute2: ip addr: Add support for setting 'optimistic'

Ido Schimmel (3):
      devlink: Add 'control' trap type
      devlink: Add 'mirror' trap action
      devlink: Document zero policer identifier

Jakub Kicinski (1):
      devlink: support kernel-side snapshot id allocation

Jamie Gloudon (1):
      tc/m_estimator: Print proper value for estimator interval in raw.

Julien Fortin (2):
      bridge: fdb get: add missing json init (new_json_obj)
      bridge: fdb show: fix fdb entry state output for json context

Louis Peens (1):
      devlink: add 'disk' to 'fw_load_policy' string validation

Maciej Fijalkowski (1):
      tc: mqprio: reject queues count/offset pair count higher than num_tc

Mark Starovoytov (2):
      macsec: add support for MAC offload
      macsec: add support for specifying offload at link add time

Matthieu Baerts (1):
      mptcp: show all endpoints when no ID is specified

Paolo Abeni (3):
      add support for mptcp netlink interface
      man: mptcp man page
      man: ip.8: add reference to mptcp man-page

Petr Machata (1):
      tc: pedit: Support JSON dumping

Po Liu (2):
      iproute2-next:tc:action: add a gate control action
      iproute2-next: add gate action man page

Roi Dayan (1):
      ip address: Fix loop initial declarations are only allowed in C99

Roman Mashak (1):
      tc: report time an action was first used

Sorah Fukumori (1):
      ip fou: respect preferred_family for IPv6

Stephen Hemminger (11):
      uapi: update headers
      devlink: update include files
      uapi: update to magic.h
      man/tc: remove obsolete reference to ipchains
      uapi: update bpf.h
      iplink_bareudp: use common include syntax
      rtacct: drop unused header
      genl: use <> for system includes
      uapi: update bpf.h
      replace SNAPSHOT with auto-generated version string
      lnstat: use same version as iproute2

Tony Ambardar (1):
      configure: support ipset version 7 with kernel version 5

Tuong Lien (1):
      tipc: enable printing of broadcast rcv link stats

William Tu (1):
      erspan: Add type I version 0 support.

Xin Long (7):
      iproute_lwtunnel: add options support for geneve metadata
      iproute_lwtunnel: add options support for vxlan metadata
      iproute_lwtunnel: add options support for erspan metadata
      tc: m_tunnel_key: add options support for vxlan
      tc: m_tunnel_key: add options support for erpsan
      tc: f_flower: add options support for vxlan
      tc: f_flower: add options support for erspan

