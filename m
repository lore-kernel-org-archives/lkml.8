Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F447C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74E09206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goEQnO2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgIAO2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:28:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728417AbgIAO1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598970422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U9xIgE3+KmrSNJy7uQ6sZ0yRjjbYaG5BWRMCjkhvH7c=;
        b=goEQnO2vz/0Xdqfh/v5izGVGGuktPm5XBYse3FGIvasZjB4ZK1SMGyPbeLROf8FoYm9yxi
        XMlZTTM7+bPjV62fTeWw5pdByFyDeCVrFSNx4h3h1dETOeRBt0VF+RlbJqA8ZEolyaUltd
        zfHjNDl39GhGl7rH83nSKzVmDGZb9HM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-U6hKbO9uMRqm7ZDuh0AcuA-1; Tue, 01 Sep 2020 10:27:00 -0400
X-MC-Unique: U6hKbO9uMRqm7ZDuh0AcuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AEDD10059A8;
        Tue,  1 Sep 2020 14:26:57 +0000 (UTC)
Received: from treble (ovpn-113-168.rdu2.redhat.com [10.10.113.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 26EC860BE2;
        Tue,  1 Sep 2020 14:26:52 +0000 (UTC)
Date:   Tue, 1 Sep 2020 09:26:51 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'x86@kernel.org'" <x86@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        'Al Viro' <viro@zeniv.linux.org.uk>,
        'Will Deacon' <will@kernel.org>,
        'Dan Williams' <dan.j.williams@intel.com>,
        'Andrea Arcangeli' <aarcange@redhat.com>,
        'Waiman Long' <longman@redhat.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Andrew Cooper' <andrew.cooper3@citrix.com>,
        'Andy Lutomirski' <luto@kernel.org>,
        'Christoph Hellwig' <hch@lst.de>
Subject: Re: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20200901142651.eir5nx4gpy63shlm@treble>
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
 <20200828192911.ezqspexfb2gtvrr7@treble>
 <f54657f1b5e74ec99cef62228db50dee@AcuMS.aculab.com>
 <56488b800d044a7e81efd8b40198a527@AcuMS.aculab.com>
 <20200831173112.fjfnnup5cfc5t226@treble>
 <93873def6ede46f89fa33b3fc78876f6@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <93873def6ede46f89fa33b3fc78876f6@AcuMS.aculab.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 08:32:20AM +0000, David Laight wrote:
> > Yes, it would make sense to put the masking in access_ok() somehow.  But
> > to do it properly, I think we'd first need to make access_ok() generic.
> > Maybe that's do-able, but it would be a much bigger patch set.
> > 
> > First I'd prefer to just fix x86, like my patch does.  Then we could do
> > an access_ok() rework.
> 
> If you do a modified access_ok() you get to (slowly) collect all
> the important paths.
> No point replicating the same test.
> 
> A lot of the access_ok() can be deleted - maybe remove some __
> from the following functions.
> Or change to the variants that enable user-space accesses.

Well, yes, but that's a much bigger job which can be done later.

-- 
Josh

