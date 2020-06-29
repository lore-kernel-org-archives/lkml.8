Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29403C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16EC6206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbgF2TW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:22:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45968 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732226AbgF2TVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:36 -0400
Received: from 89-64-84-69.dynamic.chello.pl (89.64.84.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 200f7df7d1df78b0; Mon, 29 Jun 2020 18:34:54 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dan Williams <dan.j.williams@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>
Subject: [PATCH v4 0/2] ACPI: ACPICA / OSL: Avoid unmapping ACPI memory inside of the AML interpreter
Date:   Mon, 29 Jun 2020 18:31:02 +0200
Message-ID: <1666722.UopIai5n7p@kreacher>
In-Reply-To: <2788992.3K7huLjdjL@kreacher>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com> <2713141.s8EVnczdoM@kreacher> <2788992.3K7huLjdjL@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On Friday, June 26, 2020 7:28:27 PM CEST Rafael J. Wysocki wrote:
> Hi All,
> 
> On Monday, June 22, 2020 3:50:42 PM CEST Rafael J. Wysocki wrote:
> > Hi All,
> > 
> > This series is to address the problem with RCU synchronization occurring,
> > possibly relatively often, inside of acpi_ex_system_memory_space_handler(),
> > when the namespace and interpreter mutexes are held.
> > 
> > Like I said before, I had decided to change the approach used in the previous
> > iteration of this series and to allow the unmap operations carried out by 
> > acpi_ex_system_memory_space_handler() to be deferred in the first place,
> > which is done in patches [1-2/4].
> 
> In the meantime I realized that calling syncrhonize_rcu_expedited() under the
> "tables" mutex within ACPICA is not quite a good idea too and that there is no
> reason for any users of acpi_os_unmap_memory() in the tree to use the "sync"
> variant of unmapping.
> 
> So, unless I'm missing something, acpi_os_unmap_memory() can be changed to
> always defer the final unmapping and the only ACPICA change needed to support
> that is the addition of the acpi_os_release_unused_mappings() call to get rid
> of the unused mappings when leaving the interpreter (module the extra call in
> the debug code for consistency).
> 
> So patches [1-2/4] have been changed accordingly.

And this still can be improved by using queue_rcu_work() to queue up the unused
mappings for removal in which case ACPICA need not be modified at all for the
deferred unmapping to work.

Accordingly, patches [1-2/4] from the v3 (and earlier) are now replaced by one
patch, the [1/2].

> > However, it turns out that the "fast-path" mapping is still useful on top of
> > the above to reduce the number of ioremap-iounmap cycles for the same address
> > range and so it is introduced by patches [3-4/4].
> 
> Patches [3-4/4] still do what they did, but they have been simplified a bit
> after rebasing on top of the new [1-2/4].

Moreover, the ACPICA part of the old patches [3-4/4] can be reworked to always
preserve memory mappings created by the memory opregion handler without the
need to take additional references to memory mappings at the OS level, so
patch [4/4] from the v3 (and earlier) is not needed now.

Again, for details, please refer to the patch changelogs, but I'm kind of
inclined to make these changes regardless, because they both are clear
improvements to me.

As before:

> > The series is available from the git branch at
> > 
> >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >  acpica-osl
> > 
> > for easier testing.
> 
> Also the series have been tested locally.

Cheers,
Rafael



