Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F4BC4BA20
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A92820732
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OIGX/FnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgBZSg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:36:58 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41705 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgBZSg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:36:58 -0500
Received: by mail-qt1-f193.google.com with SMTP id l21so232037qtr.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 10:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcZLgNZUBvJl2n2nxeHHbb+zy0PX2FhfitPuErDlntw=;
        b=OIGX/FnQATi2tGpoayVWr/MjgDklMgief8mHrZMct1gM/Cff+3esZ3lbA/D8QaGFG2
         EvqYAVIpa5ljzwSuDYO9GC/L4tItD10N0Li8tSEJZZtOufUV0ehxrJt2OAhK1Nr7iAkr
         AJMoM9N10eXCTIM8ap7nN+mW+j+9bGJ83XsEieHMdG4H9L15vpesOM2krZzyA7IBc+Kv
         w1Gg/uYDU9B6akelza7T1E4SfZHuytq7I2z590XpmNMITZW8jYGSk9nJIN53laWv8NCh
         A0kE1nxMEFch3VOYjVfaUY7Xl/oCPN62/OejFrOCRCFyDpuoyjawB3y4WmGW8sY+xOZV
         jRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcZLgNZUBvJl2n2nxeHHbb+zy0PX2FhfitPuErDlntw=;
        b=Qw7O5RflQ+rTt2e3beUI23c9dkJIP/vdNv+ilb/8Ed7BeG9BkqYput/OgaJXhlUD5B
         aoLA8McpEghYgkx0ywJ2L+8+TSl9BTSgS5qgahcT5JXr6knGw+U9lCVf5X+0kUUSh5su
         NnMtM80Y8lRkHnPo+NYzuCkUoLGESD2Ej7gEum5w6jkpiSu7MQLwLwU3fEE35X4HavRv
         N78rtySd2V8zmAvGwp3c7s/mNF4MsIB1NV9TUUS82rbMGJvosIfgUBW4Hvb7hB3QxD6F
         zZ/pEctyS2pR2soa/0Zh54huQEf03rJ4sM4/XQhjhgg813LvmXPPevSb/oKq83w/EAVh
         dI/g==
X-Gm-Message-State: APjAAAWSlaUvX06k1Qgf9okLnTUDUhuGgRkwp2pz2TaXED3IKc3fiDpX
        OqhCEMMAwB6lZPaWZ3TRva/2A2/TU1lMy+ucYYBusQ==
X-Google-Smtp-Source: APXvYqx5vxINGApCVBQYnWKFMoEfs56OQpou9TeW08B7KC2bM5TNvKX7udfMjDGRCuGldHlpkEJAF8/kMy8XmndBbG4=
X-Received: by 2002:ac8:67d2:: with SMTP id r18mr198178qtp.34.1582742216565;
 Wed, 26 Feb 2020 10:36:56 -0800 (PST)
MIME-Version: 1.0
References: <4e49830d-4c88-0171-ee24-1ee540028dad@virtuozzo.com> <202002251136.3816A79E@keescook>
In-Reply-To: <202002251136.3816A79E@keescook>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 26 Feb 2020 13:36:45 -0500
Message-ID: <CAJWu+oqZ+=Z1x0+Xm46Y90w=+dhub6dm+s=nU2-V9QeDn5AcrQ@mail.gmail.com>
Subject: Re: [PATCH v2] pstore: pstore_ftrace_seq_next should increase
 position index
To:     Kees Cook <keescook@chromium.org>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 2:39 PM Kees Cook <keescook@chromium.org> wrote:
>
> [merged threads]
>
> On Tue, Feb 25, 2020 at 11:11:20AM +0300, Vasily Averin wrote:
> > In Aug 2018 NeilBrown noticed
> > commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
> > "Some ->next functions do not increment *pos when they return NULL...
> > Note that such ->next functions are buggy and should be fixed.
> > A simple demonstration is
> >
> > dd if=/proc/swaps bs=1000 skip=1
> >
> > Choose any block size larger than the size of /proc/swaps.  This will
> > always show the whole last line of /proc/swaps"
> >
> > /proc/swaps output was fixed recently, however there are lot of other
> > affected files, and one of them is related to pstore subsystem.
> >
> > If .next function does not change position index, following .show function
> > will repeat output related to current position index.
> >
> > There are at least 2 related problems:
> > - read after lseek beyond end of file, described above by NeilBrown
> >   "dd if=<AFFECTED_FILE> bs=1000 skip=1" will generate whole last list
> > - read after lseek on in middle of last line will output expected rest of
> >   last line but then repeat whole last line once again.
> >
> > If .show() function generates multy-line output
> > (like pstore_ftrace_seq_show() does ?)
> > following bash script cycles endlessly
> >
> >  $ q=;while read -r r;do echo "$((++q)) $r";done < AFFECTED_FILE
> >
> > Unfortunately I'm not familiar enough to pstore subsystem and was unable to
> > find affected pstore-related file on my test node.
> >
> > If .next function does not change position index,
> > following .show function will repeat output related
> > to current position index.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code ...")
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=206283
> > Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> > ---
> >  fs/pstore/inode.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> > index 7fbe8f0..ea8799b 100644
> > --- a/fs/pstore/inode.c
> > +++ b/fs/pstore/inode.c
> > @@ -87,11 +87,11 @@ static void *pstore_ftrace_seq_next(struct seq_file *s, void *v, loff_t *pos)
> >       struct pstore_private *ps = s->private;
> >       struct pstore_ftrace_seq_data *data = v;
> >
> > +     (*pos)++;
> >       data->off += REC_SIZE;
> >       if (data->off + REC_SIZE > ps->total_size)
> >               return NULL;
> >
> > -     (*pos)++;
> >       return data;
> >  }
> >
> > --
> > 1.8.3.1
> >
>
> I think this make sense, but I figured I'd check with Joel first. Does
> this look sane for how ftrace will merge records?

The merging of the per-cpu records is completed at boot time. The
above snip is related to reading the merged records and formatting
them. It makes sense.

One thing I was not sure about is, if we move "pos" forward but still
return NULL from next(), then does show() need to check if data is
NULL? As below. Otherwise the suggested patch looks sane to me.

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 7fbe8f0582205..e3e7370b1a34d 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -101,6 +101,9 @@ static int pstore_ftrace_seq_show(struct seq_file
*s, void *v)
        struct pstore_ftrace_seq_data *data = v;
        struct pstore_ftrace_record *rec;

+       if (!data)
+               return 0;
+
        rec = (struct pstore_ftrace_record *)(ps->record->buf + data->off);

        seq_printf(s, "CPU:%d ts:%llu %08lx  %08lx  %ps <- %pS\n",
