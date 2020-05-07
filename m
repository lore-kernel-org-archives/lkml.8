Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2625C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6A22173E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgEGRom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:44:42 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:40608 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgEGRol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:44:41 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CBB0C1C0256; Thu,  7 May 2020 19:44:39 +0200 (CEST)
Date:   Thu, 7 May 2020 19:44:38 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     "Paraschiv, Andra-Irina" <andraprs@amazon.com>,
        linux-kernel@vger.kernel.org,
        Anthony Liguori <aliguori@amazon.com>,
        Benjamin Herrenschmidt <benh@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Alexander Graf <graf@amazon.de>,
        Martin Pohlack <mpohlack@amazon.de>,
        Matt Wilson <msw@amazon.com>, Balbir Singh <sblbir@amazon.com>,
        Stewart Smith <trawets@amazon.com>,
        Uwe Dannowski <uwed@amazon.de>, kvm@vger.kernel.org,
        ne-devel-upstream@amazon.com
Subject: Re: [PATCH v1 00/15] Add support for Nitro Enclaves
Message-ID: <20200507174438.GB1216@bug>
References: <20200421184150.68011-1-andraprs@amazon.com>
 <18406322-dc58-9b59-3f94-88e6b638fe65@redhat.com>
 <ff65b1ed-a980-9ddc-ebae-996869e87308@amazon.com>
 <2a4a15c5-7adb-c574-d558-7540b95e2139@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a4a15c5-7adb-c574-d558-7540b95e2139@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > it uses its own memory and CPUs + its virtio-vsock emulated device for
> > communication with the primary VM.
> > 
> > The memory and CPUs are carved out of the primary VM, they are dedicated
> > for the enclave. The Nitro hypervisor running on the host ensures memory
> > and CPU isolation between the primary VM and the enclave VM.
> > 
> > These two components need to reflect the same state e.g. when the
> > enclave abstraction process (1) is terminated, the enclave VM (2) is
> > terminated as well.
> > 
> > With regard to the communication channel, the primary VM has its own
> > emulated virtio-vsock PCI device. The enclave VM has its own emulated
> > virtio-vsock device as well. This channel is used, for example, to fetch
> > data in the enclave and then process it. An application that sets up the
> > vsock socket and connects or listens, depending on the use case, is then
> > developed to use this channel; this happens on both ends - primary VM
> > and enclave VM.
> > 
> > Let me know if further clarifications are needed.
> 
> Thanks, this is all useful.  However can you please clarify the
> low-level details here?

Is the virtual machine manager open-source? If so, I guess pointer for sources
would be useful.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
