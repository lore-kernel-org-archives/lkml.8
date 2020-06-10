Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D206EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6DDF2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgFJUvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJUvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:51:19 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1277AC03E96B;
        Wed, 10 Jun 2020 13:51:19 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 94BCB537;
        Wed, 10 Jun 2020 20:51:17 +0000 (UTC)
Date:   Wed, 10 Jun 2020 14:51:16 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] A bit more documentation for 5.8
Message-ID: <20200610145116.42bdc646@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
e35b5a4c494a75a683ddf4901a43e0a128d5bfe3:

  Documentation: fixes to the maintainer-entry-profile template (2020-06-01 09:36:07 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.8-2

for you to fetch changes up to 146f5cdeda153a1c7866cd240d2f464543d368c0:

  docs/memory-barriers.txt/kokr: smp_mb__{before,after}_atomic(): update Documentation (2020-06-08 09:42:37 -0600)

----------------------------------------------------------------
A handful of late-arriving docs fixes, along with a patch changing a lot of
HTTP links to HTTPS that had to be yanked and redone before the first
pull.

----------------------------------------------------------------
Alexander A. Klimov (1):
      Replace HTTP links with HTTPS ones: documentation

Dejin Zheng (1):
      Documentation: devres: add missing entry for devm_platform_get_and_ioremap_resource()

Heinrich Schuchardt (1):
      docs: dev-tools: coccinelle: underlines

Jonathan Corbet (1):
      docs: Update the location of the LF NDA program

Lukas Bulwahn (2):
      doc: zh_CN: use doc reference to resolve undefined label warning
      docs: it_IT: address invalid reference warnings

SeongJae Park (1):
      docs/memory-barriers.txt/kokr: smp_mb__{before,after}_atomic(): update Documentation

 Documentation/COPYING-logo                               |  2 +-
 Documentation/admin-guide/LSM/tomoyo.rst                 | 16 ++++++++--------
 Documentation/admin-guide/acpi/initrd_table_override.rst |  2 +-
 Documentation/admin-guide/bcache.rst                     |  4 ++--
 Documentation/admin-guide/devices.rst                    |  2 +-
 Documentation/admin-guide/initrd.rst                     |  2 +-
 Documentation/admin-guide/md.rst                         |  2 +-
 Documentation/admin-guide/mono.rst                       |  4 ++--
 Documentation/admin-guide/reporting-bugs.rst             |  2 +-
 Documentation/admin-guide/unicode.rst                    |  4 ++--
 Documentation/conf.py                                    |  2 +-
 Documentation/core-api/rbtree.rst                        |  4 ++--
 Documentation/dev-tools/coccinelle.rst                   |  8 ++++----
 Documentation/dev-tools/gdb-kernel-debugging.rst         |  2 +-
 Documentation/doc-guide/parse-headers.rst                |  2 +-
 Documentation/driver-api/acpi/linuxized-acpica.rst       |  6 +++---
 Documentation/driver-api/driver-model/devres.rst         |  1 +
 Documentation/driver-api/usb/bulk-streams.rst            |  4 ++--
 Documentation/driver-api/usb/writing_musb_glue_layer.rst |  6 +++---
 Documentation/filesystems/path-lookup.txt                |  2 +-
 Documentation/filesystems/seq_file.rst                   |  4 ++--
 Documentation/misc-devices/c2port.txt                    |  6 +++---
 Documentation/process/3.Early-stage.rst                  |  4 ++--
 Documentation/process/7.AdvancedTopics.rst               |  8 ++++----
 Documentation/process/8.Conclusion.rst                   | 14 +++++++-------
 Documentation/process/adding-syscalls.rst                |  4 ++--
 Documentation/process/applying-patches.rst               |  4 ++--
 Documentation/process/volatile-considered-harmful.rst    |  4 ++--
 Documentation/security/SCTP.rst                          |  2 +-
 Documentation/sphinx/kfigure.py                          |  6 +++---
 Documentation/static-keys.txt                            |  2 +-
 Documentation/trace/events-msr.rst                       |  2 +-
 Documentation/trace/mmiotrace.rst                        |  2 +-
 .../translations/it_IT/kernel-hacking/hacking.rst        |  4 ++--
 .../translations/it_IT/process/email-clients.rst         |  2 ++
 .../translations/it_IT/process/management-style.rst      |  2 ++
 Documentation/translations/ko_KR/memory-barriers.txt     | 15 +++++++++------
 Documentation/translations/zh_CN/filesystems/debugfs.rst |  2 +-
 Documentation/vm/ksm.rst                                 |  2 +-
 Documentation/xz.txt                                     |  6 +++---
 scripts/kernel-doc                                       |  2 +-
 41 files changed, 91 insertions(+), 83 deletions(-)
