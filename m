Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337ABC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 151B52081A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgFKLCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:02:32 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:50930 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbgFKLCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:02:22 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 7A959FD7E0;
        Thu, 11 Jun 2020 11:02:11 +0000 (UTC)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones:
 Documentation/translations/it_IT
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200609201241.81518-1-grandmaster@al2klimov.de>
 <4235548.LvFx2qVVIh@harkonnen>
 <cd260d03-27a4-7794-f58f-21e8e0be9755@al2klimov.de>
 <202006102009.CB14D7F@keescook>
 <8ee16c38-e28b-b4e6-ed30-55a59e216b49@al2klimov.de>
 <CANiq72n50OVRtFAQkAmqjaj=dJTP9VqYYHN7++8O_t4cbfaJgw@mail.gmail.com>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <3a6354fd-90ec-914f-b5df-0c4c219bd26e@al2klimov.de>
Date:   Thu, 11 Jun 2020 13:02:08 +0200
MIME-Version: 1.0
In-Reply-To: <CANiq72n50OVRtFAQkAmqjaj=dJTP9VqYYHN7++8O_t4cbfaJgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 11.06.20 um 12:40 schrieb Miguel Ojeda:
> On Thu, Jun 11, 2020 at 9:02 AM Alexander A. Klimov
> <grandmaster@al2klimov.de> wrote:
>>
>> Is any of you familiar with Golang?
> 
> Don't worry about that! I'd expect seasoned C programmers to be able
> to read Go (or near languages) -- at least to have a general idea of
> what an algorithm does.
> 
> It is not APL, after all :-)
Fine.


package main

import (
	"bufio"
	"bytes"
	"context"
	"errors"
	"fmt"
	fatomic "github.com/natefinch/atomic"
	"golang.org/x/sync/semaphore"
	"io"
	"io/ioutil"
	"net/http"
	"os"
	"os/exec"
	"regexp"
	"runtime"
	"sync"
	"sync/atomic"
	"time"
)

var fileSemaphore = semaphore.NewWeighted(int64(runtime.NumCPU()) * 16)
var wg sync.WaitGroup

var processingFiles = struct {
	sync.RWMutex

	files map[string]struct{}
}{
	files: map[string]struct{}{},
}

func main() {
	cmd := exec.Command("git", "ls-files", "-sz")
	cmd.Stderr = os.Stderr

	out, errSP := cmd.StdoutPipe()
	if errSP != nil {
		fmt.Fprintln(os.Stderr, errSP.Error())
		os.Exit(1)
	}

	if errSt := cmd.Start(); errSt != nil {
		fmt.Fprintln(os.Stderr, errSt.Error())
		os.Exit(1)
	}

	//go printProcessingFiles()

	buf := bufio.NewReader(out)
	for {
		file, errRB := buf.ReadBytes(0)
		if errRB != nil && errRB != io.EOF {
			if errWt := cmd.Wait(); errWt != nil {
				fmt.Fprintln(os.Stderr, errWt.Error())
				wg.Wait()
				os.Exit(1)
			}

			fmt.Fprintln(os.Stderr, errRB.Error())
			wg.Wait()
			os.Exit(1)
		}

		if bytes.HasPrefix(file, []byte{'1', '0', '0'}) {
			if fields := bytes.SplitN(bytes.SplitN(file, []byte{0}, 2)[0], 
[]byte{9}, 2); len(fields) == 2 {
				_ = fileSemaphore.Acquire(context.Background(), 1)
				wg.Add(1)
				go processFile(string(fields[1]))
			}
		}

		if errRB == io.EOF {
			break
		}
	}

	wg.Wait()

	if errWt := cmd.Wait(); errWt != nil {
		fmt.Fprintln(os.Stderr, errWt.Error())
		os.Exit(1)
	}
}

/*
func printProcessingFiles() {
	for {
		time.Sleep(time.Second)

		processingFiles.RLock()
		fmt.Fprintln(os.Stderr, processingFiles.files)
		processingFiles.RUnlock()
	}
}
*/

var httpLink = regexp.MustCompile(`\bhttp://[^# \t\r\n]*(?:\w|/)`)
var xmlns = regexp.MustCompile(`\bxmlns\b`)

func processFile(file string) error {
	defer fileSemaphore.Release(1)
	defer wg.Done()

	processingFiles.Lock()
	processingFiles.files[file] = struct{}{}
	processingFiles.Unlock()

	defer func() {
		processingFiles.Lock()
		delete(processingFiles.files, file)
		processingFiles.Unlock()
	}()

	content, errRF := ioutil.ReadFile(file)
	if errRF != nil {
		return errRF
	}

	lines := bytes.Split(content, []byte{'\n'})
	for i := range lines {
		if !xmlns.Match(lines[i]) {
			lines[i] = httpLink.ReplaceAllFunc(lines[i], processLink)
		}
	}

	if modified := bytes.Join(lines, []byte{'\n'}); bytes.Compare(modified, 
content) != 0 {
		var buf bytes.Buffer
		buf.Write(modified)
		return fatomic.WriteFile(file, &buf)
	}

	return nil
}

type linkOk struct {
	sync.Mutex

	ok uint32
}

var links = map[string]*linkOk{}
var linksLock sync.RWMutex
var notsecure = http.Client{Timeout: 10 * time.Minute}
var secure = http.Client{Timeout: 10 * time.Minute, CheckRedirect: 
httpsRedirect}

func processLink(link []byte) []byte {
	linkStr := string(bytes.TrimPrefix(link, []byte("http://")))

	linksLock.RLock()
	lo, ok := links[linkStr]
	linksLock.RUnlock()

	if !ok {
		linksLock.Lock()

		lo, ok = links[linkStr]
		if !ok {
			lo = &linkOk{}
			links[linkStr] = lo
		}

		linksLock.Unlock()
	}

	for {
		switch atomic.LoadUint32(&lo.ok) {
		case 0:
			lo.Lock()

			if atomic.LoadUint32(&lo.ok) == 0 {
				if httpsAble(linkStr) {
					atomic.StoreUint32(&lo.ok, 2)
				} else {
					atomic.StoreUint32(&lo.ok, 1)
				}
			}

			lo.Unlock()

			continue
		case 2:
			return bytes.Replace(link, []byte("http://"), []byte("https://"), 1)
		default:
			return link
		}
	}
}

func httpsAble(link string) bool {
	resp, errGt := secure.Get("https://" + link)
	if errGt != nil {
		return false
	}

	defer resp.Body.Close()

	if resp.StatusCode != 200 {
		return false
	}

	resps, errGt := notsecure.Get("http://" + link)
	if errGt != nil {
		return false
	}

	defer resps.Body.Close()

	if resps.StatusCode != 200 {
		return false
	}

	var buf, bufs bytes.Buffer

	if _, errCp := io.Copy(&buf, resp.Body); errCp != nil {
		return false
	}

	if _, errCp := io.Copy(&bufs, resps.Body); errCp != nil {
		return false
	}

	return bytes.Compare(buf.Bytes(), bufs.Bytes()) == 0
}

var insecure = errors.New("insecure")

func httpsRedirect(req *http.Request, _ []*http.Request) error {
	switch req.URL.Scheme {
	case "", "https":
		return nil
	}

	return insecure
}



> 
>>
>> @Maintainers Would any of you actually review like this? If yes, is the
>> pseudo-code not enough?
> 
> Well, Kees already mentioned he would like to see it :-) As he said,
> it is usually the way for bulk patches to present the
> algorithm/semantic patch/etc. that was used.
> 
> It is also useful to have it around so that it can be reused/reapplied
> later on, too.
If you're going to reproduce one of my patches for reviewing, checkout 
torvalds/master and travel back to the latest commit before I submitted 
the patch. Then run the algo.

> 
>> I didn't log that link-by-link. Maybe because I also didn't follow plain
>> HTTP redirects while opening HTTPS links. Maybe it even matched, but was
>> added after I made the changes.
> 
> It would be nice to have a list of links which cannot be converted,
> since nowadays they are likely to be the exception rather than the
> rule.
Don't worry, (by typing this words right now) I've noted this TODO of 
mine (after this patch round).

> 
>> * Linus *didn't even respond* (at least I didn't receive anything) to my
>> catch-them-all patch at all, not even like please not as .gz attachment
>> or please split by subsystem
> 
> Please take into account that LKML volume is huge and Linus (like
> everybody else) only reads a small subset. Further, as a general rule,
I've addressed Linus directly (CC LKML) and explicitly asked like will 
you have a look at this or not.

> Linus shouldn't be picking individual patches to begin with because
> that skips the review tree.
Who if not Linus shall review one huge patch spreading across lots of 
subsystems?

> 
> Cheers,
> Miguel
> 
