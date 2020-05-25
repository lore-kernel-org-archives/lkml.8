Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F99C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7CF20776
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbgEYQ22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 12:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731458AbgEYQ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:28:27 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9906FC061A0E;
        Mon, 25 May 2020 09:28:27 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DCC394A2;
        Mon, 25 May 2020 16:28:26 +0000 (UTC)
Date:   Mon, 25 May 2020 10:28:25 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: documentation
Message-ID: <20200525102825.63d72ed2@lwn.net>
In-Reply-To: <20200520200037.88705-1-grandmaster@al2klimov.de>
References: <20200520200037.88705-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 22:00:37 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> Rationale: Reduces attack surface on kernel devs for MITM.
> 
> Deterministic algorithm:
> For each file:
>   For each line:
>     If doesn't contain `\bxmlns\b`:
>       For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>         If both the HTTP and HTTPS versions
>         return 200 OK and serve the same content:
>           Replace HTTP with HTTPS.
> ---
>  Documentation/COPYING-logo                       |  2 +-
>  Documentation/admin-guide/LSM/tomoyo.rst         | 16 ++++++++--------
>  .../admin-guide/acpi/initrd_table_override.rst   |  2 +-
>  Documentation/admin-guide/bcache.rst             |  4 ++--
>  Documentation/admin-guide/devices.rst            |  2 +-
>  Documentation/admin-guide/initrd.rst             |  2 +-
>  Documentation/admin-guide/md.rst                 |  2 +-
>  Documentation/admin-guide/mono.rst               |  4 ++--
>  Documentation/admin-guide/reporting-bugs.rst     |  2 +-
>  Documentation/admin-guide/unicode.rst            |  4 ++--
>  Documentation/conf.py                            |  2 +-
>  Documentation/dev-tools/gdb-kernel-debugging.rst |  2 +-
>  Documentation/doc-guide/parse-headers.rst        |  2 +-
>  .../driver-api/acpi/linuxized-acpica.rst         |  6 +++---
>  Documentation/driver-api/usb/bulk-streams.rst    |  4 ++--
>  .../driver-api/usb/writing_musb_glue_layer.rst   |  6 +++---
>  Documentation/filesystems/path-lookup.txt        |  2 +-
>  Documentation/filesystems/seq_file.txt           |  4 ++--
>  Documentation/misc-devices/c2port.txt            |  6 +++---
>  Documentation/process/3.Early-stage.rst          |  2 +-
>  Documentation/process/7.AdvancedTopics.rst       |  8 ++++----
>  Documentation/process/8.Conclusion.rst           | 14 +++++++-------
>  Documentation/process/adding-syscalls.rst        |  4 ++--
>  Documentation/process/applying-patches.rst       |  4 ++--
>  .../process/volatile-considered-harmful.rst      |  4 ++--
>  Documentation/rbtree.txt                         |  4 ++--
>  Documentation/security/SCTP.rst                  |  2 +-
>  Documentation/sphinx/kfigure.py                  |  6 +++---
>  Documentation/static-keys.txt                    |  2 +-
>  Documentation/trace/events-msr.rst               |  2 +-
>  Documentation/trace/mmiotrace.rst                |  2 +-
>  Documentation/vm/ksm.rst                         |  2 +-
>  Documentation/xz.txt                             |  6 +++---
>  scripts/kernel-doc                               |  2 +-
>  34 files changed, 69 insertions(+), 69 deletions(-)

OK, so this is still pretty large; I had asked you to narrow things
further.  And the rationale is still pretty thin.  And I would *really*
rather see the docs updated in a more thoughtful way that considers the
value of the links rather than just the protocol used.

But this does not seem to do harm at this point, so I have gone ahead and
applied it.

If you proceed with this work, I'd encourage you to be narrow in your
focus, be sure to copy the right people, and to justify the changes well,
or you may well run into pushback.

Thanks,

jon
