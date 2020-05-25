Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38087C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C90C206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgEYGHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:07:23 -0400
Received: from smtprelay0013.hostedemail.com ([216.40.44.13]:56010 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729064AbgEYGHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:07:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 50FF91801E2FD;
        Mon, 25 May 2020 06:07:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tramp03_010d52726d3e
X-Filterd-Recvd-Size: 4128
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 May 2020 06:07:16 +0000 (UTC)
Message-ID: <b4d273ef6013069c6a68667a1e02204fc1e3ea39.camel@perches.com>
Subject: Re: [PATCH] twist: allow converting pr_devel()/pr_debug() into
 printk(KERN_DEBUG)
From:   Joe Perches <joe@perches.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Sun, 24 May 2020 23:07:15 -0700
In-Reply-To: <94f7ce4f-74fb-bccc-2e87-749e0c8da92c@i-love.sakura.ne.jp>
References: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
         <d65ee15211aa69a815bdc7cc4fc9e7c2e1bcba43.camel@perches.com>
         <CAFqZXNthJE0a3KkgZFXYSFArwRs0H_20KjT6KfAkiMo6WTp1rw@mail.gmail.com>
         <94f7ce4f-74fb-bccc-2e87-749e0c8da92c@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-25 at 14:03 +0900, Tetsuo Handa wrote:
> On 2020/05/25 4:18, Ondrej Mosnacek wrote:
> > I'm also not sure if this is really worth it... It would help localize
> > the bug in this specific case, but there is nothing systematic about
> > it. Are there that many debug print statements that dereference
> > pointers that are later passed to functions, but not dereferenced
> > otherwise? Maybe yes, but it seems to be quite an optimistic
> > assumption... I don't consider it such a big problem that a bug in
> > function X only manifests itself deeper in the callchain. There will
> > always be such bugs, no matter how many moles you whack.
> 
> There are about 1400 pr_debug() callers. About 1000 pr_debug() callers seem
> to pass plain '%p' (which is now likely useless for debugging purpose due to
> default ptr_to_id() conversion inside pointer()), and about 400 pr_debug()
> callers seem to pass '%p[a-zA-Z]' (which does some kind of dereference inside
> pointer()). Thus, we might find some bugs by evaluating '%p[a-zA-Z]'.
> 
> 
> 
> On Sun, May 24, 2020 at 7:38 PM Joe Perches <joe@perches.com> wrote:
> > While I think this is rather unnecessary,
> > what about dev_dbg/netdev_dbg/netif_dbg et al ?
> 
> Maybe a good idea, for there are about 24000 *dev_dbg() callers, and
> 479 callers pass '%p[a-zA-Z]'. But we can defer to another patch, in
> case this patch finds crashes before fuzz testing process starts.

There are a bunch more than that.
Some use other macros, some are functions.

$ grep-2.5.4 --include=*.[ch] -n -rP '\w+_dbg\s*\((?:[^,"]+,){0,3}\s*"[^"]+%p\w+\b[^"]*"' * | \
  perl -e 'local $/; while (<>) { s/\n\s+/ /g; print; }' | \
  grep -o -P '\w+_dbg' | \
  sort | uniq -c | sort -rn
    415 dev_dbg
    116 netdev_dbg
    100 batadv_dbg
     80 ath10k_dbg
     53 mwifiex_dbg
     49 ath11k_dbg
     29 brcmf_dbg
     28 ath_dbg
     26 ht_dbg
     20 ath6kl_dbg
     17 wcn36xx_dbg
     15 netif_dbg
     15 cifs_dbg
     14 tdls_dbg
     13 ibss_dbg
     11 mpl_dbg
     10 memblock_dbg
     10 bt_dev_dbg
      9 ps_dbg
      8 wiphy_dbg
      8 mps_dbg
      8 mlme_dbg
      8 mhwmp_dbg
      8 ipoib_dbg
      7 sta_dbg
      7 slave_dbg
      7 pci_dbg
      7 ibdev_dbg
      6 mpath_dbg
      6 en_dbg
      6 drm_dbg
      5 usnic_dbg
      5 mlx5_core_dbg
      4 vin_dbg
      4 msync_dbg
      3 rsi_dbg
      3 cal_dbg
      2 v4l2_dbg
      2 siw_dbg
      2 sdata_dbg
      2 ocb_dbg
      2 musb_dbg
      2 hw_dbg
      2 eeh_edev_dbg
      2 cifs_server_dbg
      2 at76_dbg
      1 rt2x00_eeprom_dbg
      1 pnp_dbg
      1 mthca_dbg
      1 mlx5_ib_dbg
      1 mlx4_dbg
      1 isp_dbg
      1 gfs2_print_dbg
      1 erofs_dbg
      1 dynamic_drbd_dbg
      1 ctx_dbg
      1 cs89_dbg

