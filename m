Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D67C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 01:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3DA206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 01:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7+NWtTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgC1BsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 21:48:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:27324 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbgC1BsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 21:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585360085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=R6EnIywgtvf71A2eQ8RWwmDn7nSMDNR47JwHxvv8GsI=;
        b=X7+NWtTsgdFWthWLiMy2kAlqVQdrtr4X7XsLBEwOYpwXDyRsJKiim3HN0klMl144iWu5Di
        lkkU6Qykahs2DLZvp2y3bfWQIBPhRhJPA3fSpI32c/XXQeli6VZffl3jgJLVBioOTenI50
        Qnp82FxtYOIoycwbfk0iIdibUcZOr3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-dVaTkxRaP7SZ50bnrInFFw-1; Fri, 27 Mar 2020 21:48:02 -0400
X-MC-Unique: dVaTkxRaP7SZ50bnrInFFw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6186D190B2A7;
        Sat, 28 Mar 2020 01:47:59 +0000 (UTC)
Received: from llong.com (ovpn-117-95.rdu2.redhat.com [10.10.117.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7301810016DA;
        Sat, 28 Mar 2020 01:47:55 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Sonny Rao <sonnyrao@google.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] docs: cgroup-v1: Document the cpuset_v2_mode mount option
Date:   Fri, 27 Mar 2020 21:47:48 -0400
Message-Id: <20200328014748.24140-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpuset in cgroup v1 accepts a special "cpuset_v2_mode" mount
option that make cpuset.cpus and cpuset.mems behave more like those in
cgroup v2.  Document it to make other people more aware of this feature
that can be useful in some circumstances.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v1/cpusets.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
index 86a6ae995d54..7ade3abd342a 100644
--- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
+++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
@@ -223,6 +223,17 @@ cpu_online_mask using a CPU hotplug notifier, and the mems file
 automatically tracks the value of node_states[N_MEMORY]--i.e.,
 nodes with memory--using the cpuset_track_online_nodes() hook.
 
+The cpuset.effective_cpus and cpuset.effective_mems files are
+normally read-only copies of cpuset.cpus and cpuset.mems files
+respectively.  If the cpuset cgroup filesystem is mounted with the
+special "cpuset_v2_mode" option, the behavior of these files will become
+similar to the corresponding files in cpuset v2.  In other words, hotplug
+events will not change cpuset.cpus and cpuset.mems.  Those events will
+only affect cpuset.effective_cpus and cpuset.effective_mems which show
+the actual cpus and memory nodes that are currently used by this cpuset.
+See Documentation/admin-guide/cgroup-v2.rst for more information about
+cpuset v2 behavior.
+
 
 1.4 What are exclusive cpusets ?
 --------------------------------
-- 
2.18.1

