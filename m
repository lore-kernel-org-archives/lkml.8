Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C28C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C3120727
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cGM2MeQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgCKOTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:19:31 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33626 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbgCKOTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:19:30 -0400
Received: by mail-il1-f195.google.com with SMTP id k29so2171430ilg.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 07:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69ujJbtlPdE8oHv4nVIHA9iuyZRWDdoY3VvgQ+IBL2s=;
        b=cGM2MeQBmZSBuReLBU5d5sTRAoFDL2XQyMomBEOKrqeyIMkpsthwL9Qv2AhBzaksHC
         FZlfcVPmnf9pOrb3hqBmXEtqtUjv86fzG9yFxvtSAhUSNpTVjDmB73wbXrbIMMTcJZ9W
         zNerL5x3klshUWu2R6Mt6dC6OSXgWwOaqpPMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69ujJbtlPdE8oHv4nVIHA9iuyZRWDdoY3VvgQ+IBL2s=;
        b=RdaASdvHFfQPExfqCmA/1v2y6wB2umhXuWxD4lUqsQPw2sAjsQfVMfRpaadBPLWb4Q
         RJp5HsH6kpan43EabqvXBuOtWcuOPKHj/dgYcoPyKOFy84ZOLyQ9ufoSRhGSSyarJ4+r
         0fLQ6Zwki+Ok/fl3ZyuFYA6xBQJ9vkzqdodw9p59sEKFiqqMOpnTAVkhYLdZwokcTEZ+
         L/9196sdO7aMqent71X/Fob/8hikjQFSUXRsP4cVM0tktIcngHBX9y++/EDEBF1lkwzh
         yso0zBb80hqlPrle2mNFzTNwJqCu8Hmi2FoKj8Eb1UNHCf6DRfVofgbZ7OI6QpMBYPRi
         umRA==
X-Gm-Message-State: ANhLgQ1xIO69NQmzg0Ylg/NN+yxvGrKMfyYFia/Q3KHtaW1U3A9svnfh
        G/eR9aSX+uhsq/U1P2G/mZkQ4mrm0bVEaGVtEADT6A==
X-Google-Smtp-Source: ADFU+vvoUOuyvMliGwkz0P8h8ggIixG2ZD2Fxb/0cgUuBOmTlGIQvpOe4dIt1GjgKNufXq4bt8ec4c0D2ckAdFT+N1E=
X-Received: by 2002:a92:d745:: with SMTP id e5mr3226635ilq.285.1583936369678;
 Wed, 11 Mar 2020 07:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-13-vgoyal@redhat.com>
 <CAJfpeguY8gDYVp_q3-W6JNA24zCry+SfWmEW2zuHLQLhmyUB3Q@mail.gmail.com>
 <20200310203321.GF38440@redhat.com> <CAOQ4uxh2WdLdbcMp+qvQCX2hiBx+hLO1z5wkZtc-7GCuDdsthw@mail.gmail.com>
In-Reply-To: <CAOQ4uxh2WdLdbcMp+qvQCX2hiBx+hLO1z5wkZtc-7GCuDdsthw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 11 Mar 2020 15:19:18 +0100
Message-ID: <CAJfpeguwqEsPLtph73AG7bhm1Dp4ahyJtyW=Ud7L-OFwyEmwWg@mail.gmail.com>
Subject: Re: [PATCH 12/20] fuse: Introduce setupmapping/removemapping commands
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peng Tao <tao.peng@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 8:03 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Mar 10, 2020 at 10:34 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Tue, Mar 10, 2020 at 08:49:49PM +0100, Miklos Szeredi wrote:
> > > On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > Introduce two new fuse commands to setup/remove memory mappings. This
> > > > will be used to setup/tear down file mapping in dax window.
> > > >
> > > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > > Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
> > > > ---
> > > >  include/uapi/linux/fuse.h | 37 +++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 37 insertions(+)
> > > >
> > > > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > > index 5b85819e045f..62633555d547 100644
> > > > --- a/include/uapi/linux/fuse.h
> > > > +++ b/include/uapi/linux/fuse.h
> > > > @@ -894,4 +894,41 @@ struct fuse_copy_file_range_in {
> > > >         uint64_t        flags;
> > > >  };
> > > >
> > > > +#define FUSE_SETUPMAPPING_ENTRIES 8
> > > > +#define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
> > > > +struct fuse_setupmapping_in {
> > > > +       /* An already open handle */
> > > > +       uint64_t        fh;
> > > > +       /* Offset into the file to start the mapping */
> > > > +       uint64_t        foffset;
> > > > +       /* Length of mapping required */
> > > > +       uint64_t        len;
> > > > +       /* Flags, FUSE_SETUPMAPPING_FLAG_* */
> > > > +       uint64_t        flags;
> > > > +       /* Offset in Memory Window */
> > > > +       uint64_t        moffset;
> > > > +};
> > > > +
> > > > +struct fuse_setupmapping_out {
> > > > +       /* Offsets into the cache of mappings */
> > > > +       uint64_t        coffset[FUSE_SETUPMAPPING_ENTRIES];
> > > > +        /* Lengths of each mapping */
> > > > +        uint64_t       len[FUSE_SETUPMAPPING_ENTRIES];
> > > > +};
> > >
> > > fuse_setupmapping_out together with FUSE_SETUPMAPPING_ENTRIES seem to be unused.
> >
> > This looks like leftover from the old code. I will get rid of it. Thanks.
> >
>
> Hmm. I wonder if we should keep some out args for future extensions.
> Maybe return the mapped size even though it is all or nothing at this
> point?
>
> I have interest in a similar FUSE mapping functionality that was prototyped
> by Miklos and published here:
> https://lore.kernel.org/linux-fsdevel/CAJfpegtjEoE7H8tayLaQHG9fRSBiVuaspnmPr2oQiOZXVB1+7g@mail.gmail.com/
>
> In this prototype, a FUSE_MAP command is used by the server to map a
> range of file to the kernel for io. The command in args are quite similar to
> those in fuse_setupmapping_in, but since the server is on the same host,
> the mapping response is {mapfd, offset, size}.

Right.  So the difference is in which entity allocates the mapping.
IOW whether the {fd, offset, size} is input or output in the protocol.

I don't remember the reasons for going with the mapping being
allocated by the client, not the other way round.   Vivek?

If the allocation were to be by the server, we could share the request
type and possibly some code between the two, although the I/O
mechanism would still be different.

Thanks,
Miklos
