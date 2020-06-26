Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F91C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C5B2076E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgFZH0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:26:55 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:37504 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbgFZH0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:26:55 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Jun 2020 03:26:53 EDT
Received: from ytterbium.maphy.uni-hannover.de (ytterbium.maphy.uni-hannover.de [130.75.75.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 28B2C1F55B;
        Fri, 26 Jun 2020 09:21:47 +0200 (CEST)
Received: by ytterbium.maphy.uni-hannover.de (sSMTP sendmail emulation); Fri, 26 Jun 2020 09:21:47 +0200
Date:   Fri, 26 Jun 2020 09:21:47 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v0 0/5] vt: Add SRG mouse reporting features
Message-ID: <cover.1593155911.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

this patchset adds xterm like mouse reporting features to the kernel console.

The linux virtual console has support for mouse reporting since 1994 or so,
but the kernel only supports the original X10 ("9") and X11 ("1000") style
standard protocols. To support more protocols these patches expand the kernel
structures in a downwards compatible way, see the last patch for detailed
documentation and [1] or [2] for a list and description of alls the bits
of the various protocols, as well as their limitations.

This new feature offers the following advantages :

1.) XTerm already supports all of this and as most (all?) TUI software with
    mouse support is compatible and tested with xterm, they will also work
    with the kernel console. Programs will work out of the box with this
    (if the mouse daemon supports it) and there is no need to change them.
2.) All protocols also work via ssh while the gpm protocol does not, because
    gpm uses a local socket (/dev/gpmdata) to communicate with the clients.
3.) Even the Microsoft Console does support these xterm like protocols, we
    should not let the linux console fall behind! ;-)

TTBOMK the *only* user of any of the mouse reporting interface today is
"consolation" [3]. The well known GPM does not support mouse reporting at all
(yet), see [4] for details. Of course the mouse daemons have to be adapted
too, but they will continue to work as before if they are not adapted.

[4] also originally gave the reason for these patches.

Kind regards,
Tammo


[1] https://terminalguide.namepad.de/mouse/
[2] https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h2-Mouse-Tracking
[3] https://salsa.debian.org/consolation-team/consolation/
[4] https://github.com/telmich/gpm/issues/29


Tammo Block (5):
  Change/add data structures for SRG mouse reporting
  Make it possible to enable/disable SRG mouse reporting
  Check for SRG protocol and move bit masking
  Add support for SRG report output format
  Add Documentation for console mouse reporting

 .../admin-guide/console-mouse-reporting.rst   | 82 +++++++++++++++++++
 Documentation/admin-guide/index.rst           |  1 +
 drivers/tty/vt/selection.c                    |  6 +-
 drivers/tty/vt/vt.c                           | 39 +++++++--
 include/linux/console_struct.h                |  3 +-
 include/uapi/linux/tiocl.h                    | 24 ++++--
 6 files changed, 138 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/admin-guide/console-mouse-reporting.rst

-- 
2.27.0

