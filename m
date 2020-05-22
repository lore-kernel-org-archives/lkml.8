Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45354C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188BA2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbgEVQgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:36:09 -0400
Received: from smtprelay0061.hostedemail.com ([216.40.44.61]:54824 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726762AbgEVQgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:36:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id E613418028231;
        Fri, 22 May 2020 16:36:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pan16_100eb4426d28
X-Filterd-Recvd-Size: 3024
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 22 May 2020 16:36:06 +0000 (UTC)
Message-ID: <6ab4139ec78928961a19e5fdbda139bb8cff9cb5.camel@perches.com>
Subject: Re: [PATCH] taging: speakup: remove volatile
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        MugilRaj <dmugil2000@gmail.com>
Cc:     devel@driverdev.osuosl.org, Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Chris Brannon <chris@the-brannons.com>
Date:   Fri, 22 May 2020 09:36:05 -0700
In-Reply-To: <20200522103406.GK30374@kadam>
References: <1590138989-6091-1-git-send-email-dmugil2000@gmail.com>
         <20200522103406.GK30374@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-22 at 13:34 +0300, Dan Carpenter wrote:
> On Fri, May 22, 2020 at 02:46:28PM +0530, MugilRaj wrote:
> > fix checkpatch.pl warning, which is Use of volatile is usually wrong: see
> > Documentation/process/volatile-considered-harmful.rst
> > Signed-off-by: MugilRaj <dmugil2000@gmail.com>
> 
> Please put a blank before the Signed-off-by line.
> 
> Probably there should be a space between your first and last name.  It's
> supposed to your legal name like for signing a legal document so use
> whatever is appropriate legal documents in your country.
> 
> Also the Documentation/process/volatile-considered-harmful.rst explains
> that people often use "volatile" when they should be using locking for
> synchronization.  That seems to be the case here.  So the correct fix is
> to add locking.  That's a little bit complicated to do and requires
> testing.
> 
> If we apply this patch, then we have silenced the warning so now someone
> will have to look for the bug.  But if we leave it as-is, then everyone
> will know that the code is buggy.  So let's leave it as-is until we are
> able to fix the bug.
> 
> It's always better to have easy to find bugs, than hidden bugs.

And better still to comment known opportunities to
improve the code so the next time someone tries to
remove this volatile, there's a comment right there
showing what's necessary instead.

Something like:
---
 drivers/staging/speakup/speakup_decext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/speakup/speakup_decext.c b/drivers/staging/speakup/speakup_decext.c
index 7408eb29cf38..e68e6046bb51 100644
--- a/drivers/staging/speakup/speakup_decext.c
+++ b/drivers/staging/speakup/speakup_decext.c
@@ -21,6 +21,7 @@
 #define SYNTH_CLEAR 0x03
 #define PROCSPEECH 0x0b
 
+/* TODO: Remove volatile, maybe add locks to read_buff_add and synth_full() ? */
 static volatile unsigned char last_char;
 
 static void read_buff_add(u_char ch)


