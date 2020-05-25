Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA351C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 18:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999F6207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 18:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389190AbgEYSBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 14:01:50 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:59246 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388621AbgEYSBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 14:01:50 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 359C145414;
        Mon, 25 May 2020 18:01:46 +0000 (UTC)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200520200037.88705-1-grandmaster@al2klimov.de>
 <20200525102825.63d72ed2@lwn.net>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <0b3b5ae5-457a-b550-63a8-08a77bb862d7@al2klimov.de>
Date:   Mon, 25 May 2020 20:01:45 +0200
MIME-Version: 1.0
In-Reply-To: <20200525102825.63d72ed2@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 25.05.20 um 18:28 schrieb Jonathan Corbet:
> On Wed, 20 May 2020 22:00:37 +0200
> "Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:
> 
>> Rationale: Reduces attack surface on kernel devs for MITM.
>>
>> Deterministic algorithm:
>> For each file:
>>    For each line:
>>      If doesn't contain `\bxmlns\b`:
>>        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>>          If both the HTTP and HTTPS versions
>>          return 200 OK and serve the same content:
>>            Replace HTTP with HTTPS.
>> ---
>>   Documentation/COPYING-logo                       |  2 +-
>>   Documentation/admin-guide/LSM/tomoyo.rst         | 16 ++++++++--------
>>   .../admin-guide/acpi/initrd_table_override.rst   |  2 +-
>>   Documentation/admin-guide/bcache.rst             |  4 ++--
>>   Documentation/admin-guide/devices.rst            |  2 +-
>>   Documentation/admin-guide/initrd.rst             |  2 +-
>>   Documentation/admin-guide/md.rst                 |  2 +-
>>   Documentation/admin-guide/mono.rst               |  4 ++--
>>   Documentation/admin-guide/reporting-bugs.rst     |  2 +-
>>   Documentation/admin-guide/unicode.rst            |  4 ++--
>>   Documentation/conf.py                            |  2 +-
>>   Documentation/dev-tools/gdb-kernel-debugging.rst |  2 +-
>>   Documentation/doc-guide/parse-headers.rst        |  2 +-
>>   .../driver-api/acpi/linuxized-acpica.rst         |  6 +++---
>>   Documentation/driver-api/usb/bulk-streams.rst    |  4 ++--
>>   .../driver-api/usb/writing_musb_glue_layer.rst   |  6 +++---
>>   Documentation/filesystems/path-lookup.txt        |  2 +-
>>   Documentation/filesystems/seq_file.txt           |  4 ++--
>>   Documentation/misc-devices/c2port.txt            |  6 +++---
>>   Documentation/process/3.Early-stage.rst          |  2 +-
>>   Documentation/process/7.AdvancedTopics.rst       |  8 ++++----
>>   Documentation/process/8.Conclusion.rst           | 14 +++++++-------
>>   Documentation/process/adding-syscalls.rst        |  4 ++--
>>   Documentation/process/applying-patches.rst       |  4 ++--
>>   .../process/volatile-considered-harmful.rst      |  4 ++--
>>   Documentation/rbtree.txt                         |  4 ++--
>>   Documentation/security/SCTP.rst                  |  2 +-
>>   Documentation/sphinx/kfigure.py                  |  6 +++---
>>   Documentation/static-keys.txt                    |  2 +-
>>   Documentation/trace/events-msr.rst               |  2 +-
>>   Documentation/trace/mmiotrace.rst                |  2 +-
>>   Documentation/vm/ksm.rst                         |  2 +-
>>   Documentation/xz.txt                             |  6 +++---
>>   scripts/kernel-doc                               |  2 +-
>>   34 files changed, 69 insertions(+), 69 deletions(-)
> 
> OK, so this is still pretty large; I had asked you to narrow things
> further.  And the rationale is still pretty thin.  And I would *really*
> rather see the docs updated in a more thoughtful way that considers the
> value of the links rather than just the protocol used.
OK, I'll keep that size rating in mind.

Also I'll try to reason a bit verbosely. (Not my skill #1, sorry.)

I have already one more enhancement idea, but I'd like not to have > 1 
open kernel construction areas of mine in parallel (to reduce merge 
conflicts).

> 
> But this does not seem to do harm at this point, so I have gone ahead and
> applied it.
What does this mean? Is there a kernel.org repo/branch with my patch?

> 
> If you proceed with this work, I'd encourage you to be narrow in your
> focus, be sure to copy the right people, and to justify the changes well,
> or you may well run into pushback.
I try my best while CCing, but some mailing lists seem to have 
(silently!) rejected my patch (see discussion on a previous version of 
my patch).

Does it matter whether I just feed the output of ...

perl scripts/get_maintainer.pl --separator , --norolestats 
0001-Replace-HTTP-links-with-HTTPS-ones-documentation.patch

... into Git send-email To: prompt or actually CC: (not To:) mailing lists?

> 
> Thanks,
> 
> jon
> 
