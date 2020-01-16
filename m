Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DAEC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0754A2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="sq6rBxCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437348AbgAPTHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:07:43 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35486 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388049AbgAPTHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 14:07:39 -0500
Received: by mail-lf1-f68.google.com with SMTP id 15so16406547lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 11:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EmuC4PVZIAqszrVr1XV69xZ8ppUgqhM55b6dhWz3+uk=;
        b=sq6rBxCBy/CCxrwdHmaue9zJzhbHLCVFuzGNGljHenlF/JLCURJo0cW7HCcIzob853
         ad8iNOfF7LvsNp4yActpwaksvIR5rR1SdBfmQKDabEl3I/66emZXHFCqfHyOU+Udbi20
         0tAWoeLngfq3NMIbyFzU+Ex99sYkrcGxIllnCdE+f2SBzpq4080pQlPAJlMoyjZpzPhZ
         DGGoDvZ48oTt7anYYS1ei29KQbqdWUs3CASJU/SV9rM2iPjwRMmumUYKC1mkFyvnaEte
         mMCLHi9tI/s+qcIUCXU5476/G0zj8H79xmCp+F5wrCflAzrvYOq2DBF6Ip3cme3OPkbD
         /K0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EmuC4PVZIAqszrVr1XV69xZ8ppUgqhM55b6dhWz3+uk=;
        b=CpgJ5ejlhhblqRjuuh47FqWtQQ0VT3+BJ7qLqUEhV5j9Tbe/o6FRalaWmb04t9X5OX
         FdD//7Xkja9eB/Jx0n5RRtefATlhkhF0FEzCsQvLxJQGNxGyg6TZx3Kfyotm2tUry4Fd
         HUSFL7GXxOaroXsXkRMXaxYaWObsvuciSzTE1kPbS4PYv61J5Ps9id15MEJPYB1PB6zA
         G5kKwaMmGaAs/hVzvcXOJXWwDdN72JZ6qd7mdbtteoMheBws6VucD9qHRGpaH48mTWA2
         7H149crNIDZ19HOOjMLtqnpvbjIhUkFvDXYkTJv3JL+Rw7RO05Cv4TVhsWtgxW3/9++P
         UP2Q==
X-Gm-Message-State: APjAAAVpDgeprORavEIaT5UKae7bgo7/MXwattAH7EnXx/nP8QuuznJ2
        RyxaD1VwnREKGCSjW4vy0eZ/qespjwFlL2mM4mjp
X-Google-Smtp-Source: APXvYqyjq8pmunQfve4JqN7h2RHW+MxQZLns1p+JMhm7APFS43fUdBdBp+Ertu9yeaZgxNoNEEToXqGpX1HrNrUdodI=
X-Received: by 2002:a2e:870b:: with SMTP id m11mr3237458lji.93.1579201657915;
 Thu, 16 Jan 2020 11:07:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577830902.git.rgb@redhat.com> <20200116150518.gfmzixoqagmk77rw@salvia>
In-Reply-To: <20200116150518.gfmzixoqagmk77rw@salvia>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Jan 2020 14:07:27 -0500
Message-ID: <CAHC9VhSowSdhwaGNVfj-Paj7=38z1D-p+=EDQNUAwNJpO_tyXg@mail.gmail.com>
Subject: Re: [PATCH ghak25 v2 0/9] Address NETFILTER_CFG issues
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, sgrubb@redhat.com,
        omosnace@redhat.com, fw@strlen.de, twoerner@redhat.com,
        Eric Paris <eparis@parisplace.org>, ebiederm@xmission.com,
        tgraf@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 10:05 AM Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Mon, Jan 06, 2020 at 01:54:01PM -0500, Richard Guy Briggs wrote:
> > There were questions about the presence and cause of unsolicited syscall events
> > in the logs containing NETFILTER_CFG records and sometimes unaccompanied
> > NETFILTER_CFG records.
> >
> > During testing at least the following list of events trigger NETFILTER_CFG
> > records and the syscalls related (There may be more events that will trigger
> > this message type.):
> >       init_module, finit_module: modprobe
> >       setsockopt: iptables-restore, ip6tables-restore, ebtables-restore
> >       unshare: (h?)ostnamed
> >       clone: libvirtd
> >
> > The syscall events unsolicited by any audit rule were found to be caused by a
> > missing !audit_dummy_context() check before creating a NETFILTER_CFG
> > record and issuing the record immediately rather than saving the
> > information to create the record at syscall exit.
> > Check !audit_dummy_context() before creating the NETFILTER_CFG record.
> >
> > The vast majority of unaccompanied records are caused by the fedora default
> > rule: "-a never,task" and the occasional early startup one is I believe caused
> > by the iptables filter table module hard linked into the kernel rather than a
> > loadable module. The !audit_dummy_context() check above should avoid them.
> >
> > A couple of other factors should help eliminate unaccompanied records
> > which include commit cb74ed278f80 ("audit: always enable syscall
> > auditing when supported and audit is enabled") which makes sure that
> > when audit is enabled, so automatically is syscall auditing, and ghak66
> > which addressed initializing audit before PID 1.
> >
> > Ebtables module initialization to register tables doesn't generate records
> > because it was never hooked in to audit.  Recommend adding audit hooks to log
> > this.
> >
> > Table unregistration was never logged, which is now covered.
> >
> > Seemingly duplicate records are not actually exact duplicates that are caused
> > by netfilter table initialization in different network namespaces from the same
> > syscall.  Recommend adding the network namespace ID (proc inode and dev)
> > to the record to make this obvious (address later with ghak79 after nsid
> > patches).
> >
> > See: https://github.com/linux-audit/audit-kernel/issues/25
> > See: https://github.com/linux-audit/audit-kernel/issues/35
> > See: https://github.com/linux-audit/audit-kernel/issues/43
> > See: https://github.com/linux-audit/audit-kernel/issues/44
>
> What tree is this batch targeted to?

I believe Richard was targeting this for the audit tree.

-- 
paul moore
www.paul-moore.com
