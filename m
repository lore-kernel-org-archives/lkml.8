Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86F6C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 02:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6932253D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 02:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="l5DDsU56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgA2C2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 21:28:25 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39209 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgA2C2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 21:28:24 -0500
Received: by mail-ed1-f65.google.com with SMTP id m13so16976604edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 18:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3iV3MxyrlocSSgdfDnRrrZGMfQ5DrVoOezpdS13ujbs=;
        b=l5DDsU56RPMH7PXo+gmHwoMjy/znguZo2xV96FWhBj7yKzrYs25rZKkhoMSwIrSvtq
         at9I1DhrAIBkRZBRFV3PJ5QJI2jHjgK66/mLX6aZMKXGzRFZB9eSntIBC6wlwS38cvsc
         UHA86ZErdrL/04HSinJ7c2m/JxCsMIWTjeSoMw2ijw3EJ9Sgqd8sr4HpJMUGIkZFOPg2
         oPnJ+xcdQuHprEq5p6OsXkjVMLxu5q+4AU/Y381kr7J29U3+stPYklXhWvN8XrkQ8zvu
         NvOC+iCjoC8I7hsd6cG4y67CLxvbJ9SiXNok3dju74NxrXclmcRq6yA13+NIQg6r4vW9
         ol1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3iV3MxyrlocSSgdfDnRrrZGMfQ5DrVoOezpdS13ujbs=;
        b=OzatpouHYekwbzSohCWSUAA4KIgXsgdfWDNu+3NgOGnnqdcJ/N7YWblPV2m0zmQvzH
         o6uoXwtDCveWLPvaZhhtSYqblsfvC86YSdIiMbejyCJupVqKE7CrcrwYlWePZ/U++7wJ
         xT69sQy1bZW01xGmqboT6d+uQyRdoGBKZ7iQUP8qMj8zYzxrhtVH1fdDC+zN5NVVMVxP
         Xgx3/wrgwpU0gvC79pGsGRYzwa+G1EuUXlhi7mbImJUxRS0h1xzdZUDjojtMobbdlSft
         mqdx+AH9jbWb966d6EEBcYqwl5J0D+80JPR7PPmV9oDDpyLAiMQGdebQtFi99zB+Gew7
         21WQ==
X-Gm-Message-State: APjAAAWU0pikQjHAj8rpxa0lBRBy4WsAPQMOCXmNoFAKFZNosViAp2Kg
        CpcG5rR++UwLO+ORwvUetawOTjTjTc+7f0kFLBPj
X-Google-Smtp-Source: APXvYqwocwJxvDwz1RWTX2qecVJ44CfO0kK8TeVR0Rmp3eqeo42hdCUvMCIHvGq6uDFqcz5N31WCDAietG3BEHZkkD8=
X-Received: by 2002:a17:906:f251:: with SMTP id gy17mr5497560ejb.308.1580264902710;
 Tue, 28 Jan 2020 18:28:22 -0800 (PST)
MIME-Version: 1.0
References: <20191210105037.085b3418@canb.auug.org.au> <20200129122530.7d4659f6@canb.auug.org.au>
In-Reply-To: <20200129122530.7d4659f6@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 28 Jan 2020 21:28:11 -0500
Message-ID: <CAHC9VhSB4++aQJBD9ezvX=Bq+E-XvUVb+gS1hTgJm=xj3HtBrQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with the keys tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Howells <dhowells@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jamorris@linux.microsoft.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 8:25 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,

Hello.

> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >
> > --
> > Cheers,
> > Stephen Rothwell
> >
> > diff --cc include/linux/lsm_audit.h
> > index 734d67889826,99d629fd9944..000000000000
> > --- a/include/linux/lsm_audit.h
> > +++ b/include/linux/lsm_audit.h
> > @@@ -74,7 -74,7 +74,8 @@@ struct common_audit_data
> >   #define LSM_AUDIT_DATA_FILE 12
> >   #define LSM_AUDIT_DATA_IBPKEY       13
> >   #define LSM_AUDIT_DATA_IBENDPORT 14
> >  -#define LSM_AUDIT_DATA_LOCKDOWN 15
> >  +#define LSM_AUDIT_DATA_NOTIFICATION 15
> > ++#define LSM_AUDIT_DATA_LOCKDOWN 16
> >       union   {
> >               struct path path;
> >               struct dentry *dentry;
>
> This is now a conflict between the keys tree and Linus' tree.

Presumably it basically the same as above?  If so, it should be okay
to renumber the LSM_AUDIT_DATA_xxx defines as needed, they aren't
visible to userspace in any way, and really shouldn't be visible
outside of security/.

-- 
paul moore
www.paul-moore.com
