Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DED7C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F383C20724
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgGEUug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 16:50:36 -0400
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:50974 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728056AbgGEUug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:50:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 19E2A182CED28;
        Sun,  5 Jul 2020 20:50:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pull35_340319026ea6
X-Filterd-Recvd-Size: 3449
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sun,  5 Jul 2020 20:50:33 +0000 (UTC)
Message-ID: <0334ec747d2e44a2ec3fd6147cfe139200d8b853.camel@perches.com>
Subject: Re: [PATCH 5/5] virtio_console: Constify some static variables
From:   Joe Perches <joe@perches.com>
To:     Amit Shah <amitshah@gmx.net>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Sun, 05 Jul 2020 13:50:32 -0700
In-Reply-To: <20200703175529.GE3150@trundl.on>
References: <20200701200950.30314-1-rikard.falkeborn@gmail.com>
         <20200701200950.30314-6-rikard.falkeborn@gmail.com>
         <20200703175529.GE3150@trundl.on>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-07-05 at 20:30 +0200, Amit Shah wrote:
> On (Wed) 01 Jul 2020 [22:09:50], Rikard Falkeborn wrote:
> > The id_table and feature_table pointers in struct virtio_driver are
> > pointers to const. Mark the corresponding static variables const to
> > allow the compiler to put them in read-only memory.
> > 
> > Before:
> >    text    data     bss     dec     hex filename
> >   25447     713      76   26236    667c drivers/char/virtio_console.o
> > 
> > After:
> >    text    data     bss     dec     hex filename
> >   25488     673      76   26237    667d drivers/char/virtio_console.o
> > 
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> 
> Reviewed-by: Amit Shah <amit@kernel.org>
> 
> Please CC me on the entire series instead of individual patches in the
> future.

CC'ing individual maintainers on entire patch sets
that span multiple subsystems doesn't scale.

Given that lore.kernel.org now stores all emails
sent to lkml, it's a reasonable thing to add a
reference to the cover letter below the --- line
to make it easier for individual recipients of
patches in a series to find the entire patch set.

i.e. Send emails with something like:

Subject: [PATCH N/M] foo: bar

commit message

Signed-off-by: J. Random Developer <address@domain.tld>
---

Link: https://lore.kernel.org/r/<message_id_of_cover_letter>

[patch]

A trivial script to insert these links if all patches
in a series are stored in a separate directory:

$ bash insert_cover_letter_link.bash <patch_directory>

---
$ cat insert_cover_letter_link.bash
#!/bin/bash

find $@ -name "*.patch" | sort | \
    while read file ; do

	echo "File: <$file>"
	if [[ $(basename $file) =~ ^0000- ]] ; then
	    message_id=$(grep '^Message-Id: <' $file)
	    if [ $? -ne 0 ] ; then
		echo "Message_Id not found"
		exit 1
	    fi
	    message_id=$(echo $message_id | \
			     sed -r -e 's/^Message-Id:\s*<//' -e 's/>\s*$//')
	    separator="-- "
	    echo "Message_Id: <$message_id>"
	else
	    separator="---"
	fi
	
	if [[ "$message_id" == "" ]] ; then
	    echo "Patch series cover letter Message_Id not found"
	    exit 1
	fi

	perl -n -i -e "if (\$_ =~ /^$separator$/) { print; print \"\\n\"; print \"Link: https://lore.kernel.org/r/\" . '$message_id' . \"\\n\"; print \"\\n\"; } else { print; }" $file

    done

exit 0


