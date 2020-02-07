Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37539C35250
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A51320838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgBGRmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 12:42:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:54472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbgBGRmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:42:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 472B1ACD9;
        Fri,  7 Feb 2020 17:42:45 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-man@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Zorro Lang <zlang@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] New mount API syscalls
Date:   Fri,  7 Feb 2020 18:42:34 +0100
Message-Id: <20200207174236.18882-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, Michael,

looks like David's patches to add new mount API syscalls, so I dared to
resent them. I've just changed kernel version to 5.2, fixed typos in
flags and added my tags. + added some questions in patches themselves.

Feel free to send final version in v3.

Kind regards,
Petr

David Howells (2):
  Add manpages for move_mount(2) and open_tree(2)
  Add manpage for fsopen(2), fspick(2) and fsmount(2)

 man2/fsconfig.2   | 282 ++++++++++++++++++++++++++++++++++++++++++++++
 man2/fsmount.2    |   1 +
 man2/fsopen.2     | 256 +++++++++++++++++++++++++++++++++++++++++
 man2/fspick.2     | 195 ++++++++++++++++++++++++++++++++
 man2/move_mount.2 | 271 ++++++++++++++++++++++++++++++++++++++++++++
 man2/open_tree.2  | 260 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 1265 insertions(+)
 create mode 100644 man2/fsconfig.2
 create mode 100644 man2/fsmount.2
 create mode 100644 man2/fsopen.2
 create mode 100644 man2/fspick.2
 create mode 100644 man2/move_mount.2
 create mode 100644 man2/open_tree.2

-- 
2.24.1

