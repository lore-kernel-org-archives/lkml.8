Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39BBC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 04:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A974D20737
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 04:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387708AbgCLEoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 00:44:02 -0400
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:42318 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727099AbgCLEoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 00:44:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 5BAE41801E57D;
        Thu, 12 Mar 2020 04:44:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: coil35_22f9bd1ddff3a
X-Filterd-Recvd-Size: 2150
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Mar 2020 04:44:00 +0000 (UTC)
Message-ID: <4aadd119d4336de9eafcfbadb951630eb0cf2eb9.camel@perches.com>
Subject: Re: [PATCH] checkpatch: always allow C99 SPDX License Identifer
 comments
From:   Joe Perches <joe@perches.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Andy Whitcroft <apw@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Date:   Wed, 11 Mar 2020 21:42:17 -0700
In-Reply-To: <7056bd62-4251-f9bb-2b97-15f93a1e7142@broadcom.com>
References: <20200311191128.7896-1-scott.branden@broadcom.com>
         <2c4b42d1fb0bdb6604a72b2a10d49f9eae4b0ff4.camel@perches.com>
         <7056bd62-4251-f9bb-2b97-15f93a1e7142@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-11 at 19:48 -0700, Scott Branden wrote:
> Hi Joe,
> 
> On 2020-03-11 7:26 p.m., Joe Perches wrote:
> > On Wed, 2020-03-11 at 12:11 -0700, Scott Branden wrote:
> > > Always allow C99 comment styles if SPDK-License-Identifier is in comment
> > > even if C99_COMMENT_TOLERANCE is specified in the --ignore options.
> > Why is this useful?
> This is useful because if you run checkpatch with 
> --ignore=C99_COMMENT_TOLERANCE
> right now it will warn on almost every .c file in the linux kernel due 
> to the decision to
> use // SPDX-License-Identifier: at the start of every c file

Maybe this is better:

Just don't perform any other per-line checks on a valid or invalid
SPDX line.

---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 529c892..3f2ae7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3171,6 +3171,7 @@ sub process {
 						WARN("SPDX_LICENSE_TAG",
 						     "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
 					}
+					next;
 				}
 			}
 		}


