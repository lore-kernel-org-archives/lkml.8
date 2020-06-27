Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35EDC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 15:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E29221655
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 15:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHH614oJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgF0PTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 11:19:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21993 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725975AbgF0PS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 11:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593271135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=C4M0Ba5Ra4A0tyskw/Kq90KeC+eoL17StqPFkLGa6W0=;
        b=HHH614oJtN1LzLjzdLGMVPnVIBYAzbJlklZmogBezw3grRaaYG+bKh46N4ifh/i3UK7BOq
        HdawCNa8tWULqmc7IvfjXpqXlc1mazpkdJsQID4+/tAXLQ1mW1wikRUiCs+uSfYvwpHMNn
        Ou4ZCOhaOV5iXqBQK1Lgz4OUuyzat3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-Xi90i6W4NjuFum5_IEyvSg-1; Sat, 27 Jun 2020 11:18:51 -0400
X-MC-Unique: Xi90i6W4NjuFum5_IEyvSg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AB0E107ACCA;
        Sat, 27 Jun 2020 15:18:44 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 886DA60BF4;
        Sat, 27 Jun 2020 15:18:36 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v9 00/11] add support for audit container identifier
Date:   Sat, 27 Jun 2020 11:18:00 -0400
Message-Id: <1593271091-30188-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for audit kernel container identifiers to userspace tools.

The first and second add new record types.  The third adds filter
support.  The fourth and 5th start to add search support.

The 6th is to read the calling process' audit container identifier from
the /proc filesystem matching the kernel /proc read patch.

The 7th is to fix signal support and the 8th is to learn the audit
container identifier of the process that signals the audit daemon.

The 9th is a touch up to allow the contid field to be interpreted as a
CSV list.

The 10th adds audit contid list support to ausearch.

The last adds audit library support to allow a process to give
permission to a container orchestrator in a non-init user namespace via
audit netlink messages.

See: https://github.com/linux-audit/audit-userspace/issues/51
See: https://github.com/linux-audit/audit-userspace/issues/40
See: https://github.com/linux-audit/audit-kernel/issues/90
See: https://github.com/linux-audit/audit-kernel/issues/91
See: https://github.com/linux-audit/audit-testsuite/issues/64
  https://githu.com/linux-audit/audit-testsuite/pull/91
  https://github.com/rgbriggs/audit-testsuite/tree/ghat64-contid
See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID

A repo of the code is here:
  git@github.com:rgbriggs/audit-userspace.git ghau40-containerid-filter.v9
And test rpms built from it are here:
  people.redhat.com/~rbriggs/ghak90/git-8277e93-fc32

Changelog:
v9
- accept a contid list for sig_info2
- bump AUDIT_CONTAINER_ID to 1336 to accommodate AUDIT_EVENT_LISTENER
- fix logical result reversal in audit_signal_info_has_ctx()
- fix event_contid clist declaration, fix comment about CONTAINER_OP/ID old-/contid CSV
- add SET_CAPCONTID to lib/netlink.c adjust_reply() and check_events()
- rebase on ghak28 parser
- rebase on ghak25 parser
- rebase on ghau86 fix
- in auparse/interpret.c:print_contid() also detect "-1"
- remove patches to limit nesting depth and netns count
- whitespace fixes
- squash clist into slist
- simplify audit_[sg]et_capcontid()

v8
- renumber contid records and drop netlink contid set/get support
- remove subject attributes from parse_container_op()
- fix audit_request_signal_info.3 manpage
- add manpage for audit_set_capcontid()
- implement clist for contid list search
- rebase on audit_bpf patches (bump CONTAINER_ID to 1335)
- implement control for audit container identifier nesting depth limit with manpage
- implent control for audit container identifier netns count limit with manpage

v7
- rebase on ghau90 and touchup
- rebase on ghak10 support (change AUDIT_CONTAINER_ID to 1334)
- render type contid as a CSV
- switch from /proc to audit netlink to set/get contid, auid/sessionid
- add support for capcontid

v6
- auditd signaller tracking was moved to a new AUDIT_SIGNAL_INFO2
  request and record
- swap CONTAINER_OP contid/old-contid to ease parsing
- add to auparse

v5
- updated aux record from AUDIT_CONTAINER to AUDIT_CONTAINER_ID
- add AUDIT_CONTAINER_ID to normalization
- rebase on AUDIT_ANOM_LINK and AUDIT_MAC_CALIPSO_ADD

v4
- change from AUDIT_CONTAINER_ID to AUDIT_CONTAINER_OP
- change from AUDIT_FEATURE_BITMAP_CONTAINERID_FILTER to
  AUDIT_FEATURE_BITMAP_CONTAINERID
- change from event_container_id to event_contid internally
- change from container_id to contid and event_container_id to
  event_contid internally
- change command line option from --container-id to --contid

v3
- change from AUDIT_CONTAINER to AUDIT_CONTAINER_ID
- change from AUDIT_CONTAINER_INFO to AUDIT_CONTAINER
- change from AUDIT_CONTAINERID to AUDIT_CONTID
- update github issue refs
- add audit_get_containerid
- change event_container_id default value
- add --containerid to ausearch options help text
- update ausearch parser and error codes

v2
- rebase on UINT_MAX patch
- add patches for AUDIT_CONTAINER, AUDIT_CONTAINER_INFO, ausearch,
  normalization

Richard Guy Briggs (11):
  AUDIT_CONTAINER_OP message type basic support
  AUDIT_CONTAINER_ID message type basic support
  auditctl: add support for AUDIT_CONTID filter
  add ausearch containerid support
  start normalization containerid support
  libaudit: add support to get the task audit container identifier
  signal_info: only print context if it is available.
  add support for audit_signal_info2
  contid: interpret correctly CONTAINER_ID contid field csv
  ausearch: convert contid to comma-sep/carrat-mod cnode/clist
  libaudit: add support to get and set capcontid on a task

 auparse/auditd-config.c          |   1 +
 auparse/auparse-defs.h           |   3 +-
 auparse/interpret.c              |  10 +++
 auparse/normalize.c              |   1 +
 auparse/normalize_record_map.h   |   3 +
 auparse/typetab.h                |   2 +
 bindings/python/auparse_python.c |   1 +
 docs/Makefile.am                 |   3 +-
 docs/audit_get_capcontid.3       |  25 ++++++
 docs/audit_get_containerid.3     |  25 ++++++
 docs/audit_request_signal_info.3 |  15 +++-
 docs/audit_set_capcontid.3       |  24 +++++
 docs/auditctl.8                  |   3 +
 lib/fieldtab.h                   |   1 +
 lib/libaudit.c                   | 188 +++++++++++++++++++++++++++++++++++++--
 lib/libaudit.h                   |  36 +++++++-
 lib/msg_typetab.h                |   4 +
 lib/netlink.c                    |   6 ++
 src/Makefile.am                  |   6 +-
 src/auditctl-listing.c           |  21 +++++
 src/auditd-config.c              |   1 +
 src/auditd-config.h              |   1 +
 src/auditd-event.c               |  28 ++++--
 src/auditd-reconfig.c            |  27 ++++--
 src/auditd.c                     |   4 +-
 src/aureport-options.c           |   2 +
 src/ausearch-contid.c            | 172 +++++++++++++++++++++++++++++++++++
 src/ausearch-contid.h            |  60 +++++++++++++
 src/ausearch-llist.c             |   6 ++
 src/ausearch-llist.h             |   2 +
 src/ausearch-lol.c               |   4 +
 src/ausearch-match.c             |  35 ++++++++
 src/ausearch-options.c           |  78 +++++++++++++++-
 src/ausearch-options.h           |   2 +
 src/ausearch-parse.c             | 124 ++++++++++++++++++++++++++
 src/ausearch-report.c            |   6 +-
 36 files changed, 898 insertions(+), 32 deletions(-)
 create mode 100644 docs/audit_get_capcontid.3
 create mode 100644 docs/audit_get_containerid.3
 create mode 100644 docs/audit_set_capcontid.3
 create mode 100644 src/ausearch-contid.c
 create mode 100644 src/ausearch-contid.h

-- 
1.8.3.1

